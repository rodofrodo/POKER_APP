#pragma once
#include <QObject>
#include <QTcpSocket>
#include <QString>
#include <QStringList>
#include "general/globals.h"
#include "general/Utils.h"
#include "engine/prompt_options.h"
#include "classes/Player.h"

class Backend : public QObject
{
Q_OBJECT
// A property to show connection status in the UI
Q_PROPERTY(QString statusMessage READ statusMessage NOTIFY statusChanged)
Q_PROPERTY(QString ipAddress READ getIpAddress NOTIFY connectionDetailsChanged)
Q_PROPERTY(QString port READ getPort NOTIFY connectionDetailsChanged)
Q_PROPERTY(QString clientName READ getName NOTIFY updatedName)
Q_PROPERTY(QString lobbySize READ getLobbySize NOTIFY updatedLobbySize)
Q_PROPERTY(QStringList playerList READ getPlayerList NOTIFY playerListChanged)

Q_PROPERTY(QString leftCard READ getLeftCard NOTIFY updatedGamePage)
Q_PROPERTY(QString rightCard READ getRightCard NOTIFY updatedGamePage)

Q_PROPERTY(QString bettingRound READ getBettingRound NOTIFY updatedGamePage)
Q_PROPERTY(QString potVal READ getPotValue NOTIFY updatedGamePage)
Q_PROPERTY(QStringList comCards READ getCommunityCards NOTIFY updatedGamePage)
Q_PROPERTY(QStringList betOpts READ getBetOpts NOTIFY updatedGamePage)
Q_PROPERTY(QString topbetVal READ getTopbetValue NOTIFY updatedGamePage)

Q_PROPERTY(QString winners READ getWinners NOTIFY updatedGamePage)

Q_PROPERTY(int uiTrigger READ getUiTrigger NOTIFY updatedGamePage)

Q_PROPERTY(QString raiseVal READ getRaiseVal NOTIFY raiseValueChanged)

public:
    explicit Backend(QObject* parent = nullptr);
    QString statusMessage() const;

    QString getIpAddress() const { return m_ipAddress; }
    QString getPort() const { return m_port; }
    QString getName() const { return m_clientName; }
    QString getLobbySize() const { return QString::number(playerInLobby); }
    QStringList getPlayerList() const { return m_playerList; }

    QString getLeftCard() const { return QString::fromStdString(
        playerMap[m_clientName].leftCard.toString()); }
    QString getRightCard() const { return QString::fromStdString(
        playerMap[m_clientName].rightCard.toString()); }

    // change order for that one
    QString getWinners() const
    {
        QString qsl;
        if (currentGameState == GameState::GAME_OVER)
            qsl.append("The winner is " + globalDefaultWinner);
        else if (currentGameState == GameState::SHOWDOWN)
        {
            if (globalWinningCards.size() > 1 && globalWinningType == "normal")
            {
                qsl.append("\n--- IT'S A TIE! ---\n");
                qsl.append(globalWinningCards.size() + " players have the same winning hand!\n\n");
            }
            else if (globalWinningType == "sidepot")
            {
                qsl.append("\n--- DISTRIBUTION OF SIDEPOTS ---\n");
                qsl.append(globalWinningCards.size() + " sidepots are distributed.\n\n");
            }
            for (size_t i = 0; i < globalWinningCards.size(); i++)
                qsl.append(globalWinningMsg[i] + "\n");
        }
        else qsl.append("");
        return qsl;
    }

    QString getBettingRound() const
    { 
        QString round;
        if (currentGameState == GameState::DEALING_CARDS)
            round = "DEALING CARDS";
        else if (currentGameState == GameState::BETTING_ROUND)
            round = QString::fromStdString(utils::getBettingRound(currentBettingRound));
        else if (currentGameState == GameState::SHOWDOWN)
            round = "SHOWDOWN";
        else if (currentGameState == GameState::GAME_OVER)
            round = "GAME OVER";
        return round;
    }

    QString getPotValue() const { return "$" + QString::number(pot / 100.0, 'f', 2); }

    QStringList getCommunityCards() const
    {
        QStringList r;
        for (const auto& x : communityCards)
            r.append(QString::fromStdString(x.toString()));
        return r;
    }

    QStringList getBetOpts() const
    {
        QStringList qsl;
        if (gotPlayers && currentGameState == GameState::BETTING_ROUND)
            if (m_clientName == playerNames[currentPlayer])
                return prompt::getAvailableOptions(topbet, playerMap[m_clientName]);
        for (int i = 0; i < 3; i++) qsl.append("-");
        return qsl;
    }

    QString getTopbetValue() const
    {
        if (topbet.value == VAL::CLEAR || topbet.value == VAL::EMPTY)
            return "NONE";
        return "$" + QString::number(topbet.value / 100.0, 'f', 2); 
    }

    // Q_INVOKABLE allows QML to call this C++ function
    Q_INVOKABLE void connectToServer(const QString& ip, const QString& port);
    Q_INVOKABLE void sendMessage_public(const QString& msg);
    Q_INVOKABLE void updateName(const QString& name);

    // moves
    Q_INVOKABLE void _match_bet(); // check or call
    Q_INVOKABLE void _change_bet_open(); // bet or raise
    Q_INVOKABLE void _change_bet_confirm();
    Q_INVOKABLE void _fold(); // fold

    // design
    Q_INVOKABLE QString getPlayerName(int index) { return m_playerList[index]; }

    Q_INVOKABLE QString getBettingState(int index)
    {
        if (playerMap.size() == 0) return "";
        if (playerMap[playerNames[index]].isDealer) return "DEALER";
        if (playerMap[playerNames[index]].bettingState == BettingState::SMALL_BLIND)
            return "SMALL BLIND";
        if (playerMap[playerNames[index]].bettingState == BettingState::BIG_BLIND)
            return "BIG BLIND";
        return "NORMAL";
    }

    Q_INVOKABLE QString getBalance(int index)
    {
        if (playerMap.size() == 0) return "";
        double balance = playerMap[playerNames[index]].balance / 100.0;
        return "$" + QString::number(balance, 'f', 2);
    }

    Q_INVOKABLE QString getLoans(int index)
    { 
        if (playerMap.size() == 0) return "";
        return QString::number(playerMap[playerNames[index]].loans); 
    }

    Q_INVOKABLE QString getCurrentBet(int index)
    {
        if (playerMap.size() == 0) return "";
        if (playerMap[playerNames[index]].hasFolded)
            return "FOLDED";
        if (playerMap[playerNames[index]].currentBet.value == VAL::CLEAR)
            return "None";
        
        double betValue = playerMap[playerNames[index]].currentBet.value / 100.0;
        return "$" + QString::number(betValue, 'f', 2);
    }

    Q_INVOKABLE QString getActingPlayer(int index)
    {
        if (playerMap.size() == 0) return "";
        if (playerMap[playerNames[currentPlayer]].name == playerMap[playerNames[index]].name
            && currentGameState == GameState::BETTING_ROUND)
            return "<<<";
        return "";
    }

    // raise options
    Q_INVOKABLE void increaseBet()
    {
        if (m_clientName == playerNames[currentPlayer])
        {
            //TUPLE::MinMax res = prompt::getDifferentBetOptions(topbet, playerMap[playerNames[currentPlayer]]);
            //if (m_raiseVal + 500 <= res.max)
            {
                m_raiseVal += 500;
                emit raiseValueChanged();
            }
        }
    }

    Q_INVOKABLE void decreaseBet()
    {
        if (m_clientName == playerNames[currentPlayer])
        {
            TUPLE::MinMax res = prompt::getDifferentBetOptions(topbet, playerMap[playerNames[currentPlayer]]);
            if (m_raiseVal - 500 >= res.min)
            {
                m_raiseVal -= 500;
                emit raiseValueChanged();
            }
        }
    }

    QString m_ipAddress;
    QString m_port;
    QString m_clientName;

signals:
    void statusChanged();
    void connectedToServer();
    void lobbyReady();
    void connectionDetailsChanged();
    void updatedName();
    void updatedLobbySize();
    void gameReady();
    void playerListChanged();
    void updatedGamePage();
    void raiseValueChanged();

private:
    QTcpSocket* m_socket;
    QString m_status;
    bool hasConnected = false;
    QStringList m_playerList;
    QString m_buffer;

    bool gotPlayers = false;
    bool gotGameInfo = false;
    bool gotCommunityCards = false;
    bool gotPlayerCards = false;

    void setStatus(const QString& msg);
	void sendMessage(const QString& msg);
	void onReadyRead();

    void processBuffer(const QString& msg);
    void nextPlayer();
    void _update();

    int m_uiTrigger = 0;
    int getUiTrigger() const { return m_uiTrigger; }

    int m_raiseVal = 500;
    QString getRaiseVal() const
    { return "$" + QString::number(m_raiseVal / 100.0, 'f', 2); }
};
