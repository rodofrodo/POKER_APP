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
Q_PROPERTY(int clientIndex READ getClientIndex NOTIFY updatedGamePage)

Q_PROPERTY(QString leftCard READ getLeftCard NOTIFY updatedGamePage)
Q_PROPERTY(QString rightCard READ getRightCard NOTIFY updatedGamePage)

Q_PROPERTY(bool isActingPlayer READ getIsActingPlayer NOTIFY updatedGamePage)
Q_PROPERTY(QString bettingRound READ getBettingRound NOTIFY updatedGamePage)
Q_PROPERTY(QString potVal READ getPotValue NOTIFY updatedGamePage)
Q_PROPERTY(QStringList comCards READ getCommunityCards NOTIFY updatedGamePage)
Q_PROPERTY(QStringList betOpts READ getBetOpts NOTIFY updatedGamePage)
Q_PROPERTY(QString topbetVal READ getTopbetValue NOTIFY updatedGamePage)
Q_PROPERTY(QString winners READ getWinners NOTIFY updatedGamePage)
Q_PROPERTY(int uiTrigger READ getUiTrigger NOTIFY updatedGamePage)

Q_PROPERTY(QString raiseVal READ getRaiseVal NOTIFY raiseValueChanged)
Q_PROPERTY(double raiseUpOpacity READ getRaiseUpOpacity NOTIFY raiseValueChanged)
Q_PROPERTY(double raiseDownOpacity READ getRaiseDownOpacity NOTIFY raiseValueChanged)
Q_PROPERTY(QString raiseUpText READ getRaiseUpText NOTIFY raiseValueChanged)

public:
    explicit Backend(QObject* parent = nullptr);

    QString statusMessage() const;
    QString getIpAddress() const;
    QString getPort() const;
    QString getName() const;
    QString getLobbySize() const;
    QStringList getPlayerList() const;
	int getClientIndex() const;

    QString getLeftCard() const;
    QString getRightCard() const;

	bool getIsActingPlayer() const;
    QString getBettingRound() const;
    QString getPotValue() const;
    QStringList getCommunityCards() const;
    QStringList getBetOpts() const;
    QString getTopbetValue() const;
    QString getWinners() const;
    int getUiTrigger() const;

    QString getRaiseVal() const;
	double getRaiseUpOpacity() const;
    double getRaiseDownOpacity() const;
    QString getRaiseUpText() const;

    // Q_INVOKABLE allows QML to call this C++ function
    Q_INVOKABLE void connectToServer(const QString& ip, const QString& port);
    Q_INVOKABLE void sendMessage_public(const QString& msg);
    Q_INVOKABLE void updateName(const QString& name);

    // moves
    Q_INVOKABLE void _match_bet(); // check or call
    Q_INVOKABLE void _change_bet_open(); // bet or raise
    Q_INVOKABLE void _change_bet_confirm();
    Q_INVOKABLE void _fold(); // fold
    Q_INVOKABLE void increaseBet();
    Q_INVOKABLE void decreaseBet();

    // design
    Q_INVOKABLE QString getPlayerName(int index);
    Q_INVOKABLE QString getBettingState(int index);
    Q_INVOKABLE QString getBalance(int index);
    Q_INVOKABLE QString getLoans(int index);
    Q_INVOKABLE QString getCurrentBet(int index);
    Q_INVOKABLE QString getActingPlayer(int index);
    Q_INVOKABLE QString getBackground(int index);
    Q_INVOKABLE QString getTextColor(int index);
    Q_INVOKABLE QString getPriceTextColor(int index);
    Q_INVOKABLE QString getLeftCard(int index);
	Q_INVOKABLE QString getRightCard(int index);
	Q_INVOKABLE double getOpacity(int index);

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
    int m_uiTrigger;
    int m_raiseVal;

    bool gotPlayers;
    bool gotGameInfo;
    bool gotCommunityCards;
    bool gotPlayerCards;

    void setStatus(const QString& msg);
	void sendMessage(const QString& msg);
	void onReadyRead();
    void processBuffer(const QString& msg);
    void _update();
    void nextPlayer();
};
