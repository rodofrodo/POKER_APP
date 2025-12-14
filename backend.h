#pragma once
#include <QObject>
#include <QTcpSocket>
#include <QString>
#include <QStringList>
#include "general/globals.h"
#include "general/Utils.h"

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

    // Q_INVOKABLE allows QML to call this C++ function
    Q_INVOKABLE void connectToServer(const QString& ip, const QString& port);
    Q_INVOKABLE void sendMessage_public(const QString& msg);
    Q_INVOKABLE void updateName(const QString& name);

    // moves
    Q_INVOKABLE void _match_bet(); // check or call
    Q_INVOKABLE void _change_bet(); // bet or raise
    Q_INVOKABLE void _fold(); // fold

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

private:
    QTcpSocket* m_socket;
    QString m_status;
    bool hasConnected = false;
    QStringList m_playerList;
    QString m_buffer;

    void setStatus(const QString& msg);
	void sendMessage(const QString& msg);
	void onReadyRead();

    void processBuffer(const QString& msg);
    void nextPlayer();
};
