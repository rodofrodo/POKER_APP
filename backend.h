#pragma once
#include <QObject>
#include <QTcpSocket>
#include <QString>
#include <QStringList>
#include "general/globals.h"
#include "general/Utils.h"
#include "engine/prompt_options.h"
#include "classes/Player.h"
#include "engine/margin_calc.h"

class Backend : public QObject
{
Q_OBJECT

#pragma region QML Properties
Q_PROPERTY(QString statusMessage READ statusMessage NOTIFY statusChanged)
Q_PROPERTY(QString ipAddress READ getIpAddress NOTIFY connectionDetailsChanged)
Q_PROPERTY(QString port READ getPort NOTIFY connectionDetailsChanged)
Q_PROPERTY(QString nameProblem READ nameProblem NOTIFY nameProblemTriggered)
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
Q_PROPERTY(QStringList sidePots READ getSidePots NOTIFY updatedGamePage)

Q_PROPERTY(QString raiseVal READ getRaiseVal NOTIFY raiseValueChanged)
Q_PROPERTY(double raiseUpOpacity READ getRaiseUpOpacity NOTIFY raiseValueChanged)
Q_PROPERTY(double raiseDownOpacity READ getRaiseDownOpacity NOTIFY raiseValueChanged)
Q_PROPERTY(QString raiseUpText READ getRaiseUpText NOTIFY raiseValueChanged)
#pragma endregion

public:
    /// <summary>
	/// The constructor for the Backend class.
	/// It handles communication between the UI and the poker game server.
    /// </summary>
    explicit Backend(QObject* parent = nullptr);

#pragma region Getters
	/// <summary>
	/// Getter for a connection status message
	/// </summary>
	/// <returns>The message</returns>
	QString statusMessage() const;

    /// <summary>
    /// Getter for the IP address
    /// </summary>
    /// <returns>The IP address</returns>
    QString getIpAddress() const;

    /// <summary>
    /// Getter for the server port
    /// </summary>
    /// <returns>The server port</returns>
    QString getPort() const;

    /// <summary>
    /// Getter for the nickname problem
    /// </summary>
    /// <returns>The nickname problem</returns>
	QString nameProblem() const;

    /// <summary>
    /// Getter for the player's nickname 
    /// </summary>
    /// <returns>The player's nickname</returns>
    QString getName() const;

    /// <summary>
    /// Getter for the lobby size (i.e. how many players there are)
    /// </summary>
    /// <returns>The lobby size</returns>
    QString getLobbySize() const;

    /// <summary>
    /// Getter for the player list (i.e. their names)
    /// </summary>
    /// <returns>The player list</returns>
    QStringList getPlayerList() const;

    /// <summary>
    /// Getter for the client index
    /// </summary>
    /// <returns>The client index</returns>
	int getClientIndex() const;

    /// <summary>
    /// Getter for the client left card
    /// </summary>
    /// <returns>The client left card</returns>
    QString getLeftCard() const;

    /// <summary>
    /// Getter for the client right card
    /// </summary>
    /// <returns>The client right card</returns>
    QString getRightCard() const;

    /// <summary>
    /// Getter checking is client is the current player
    /// </summary>
    /// <returns>True if client is the acting player; otherwise false</returns>
	bool getIsActingPlayer() const;

    /// <summary>
    /// Getter for the betting round (PRE-FLOP, FLOP, TURN, RIVER)
    /// </summary>
    /// <returns>The betting round</returns>
    QString getBettingRound() const;

    /// <summary>
    /// Getter for the pot value
    /// </summary>
    /// <returns>The pot value</returns>
    QString getPotValue() const;

    /// <summary>
    /// Getter for the string list of community cards
    /// </summary>
    /// <returns>The string list of community cards</returns>
    QStringList getCommunityCards() const;

    /// <summary>
    /// Getter for the string list of betting options
    /// </summary>
    /// <returns>The string list of betting options</returns>
    QStringList getBetOpts() const;

    /// <summary>
    /// Getter for the value of the highest bet
    /// </summary>
    /// <returns>The value of the highest bet</returns>
    QString getTopbetValue() const;

    /// <summary>
    /// The UI trigger
    /// </summary>
    /// <returns>（づ￣3￣）づ╭❤️～ (for real returning value is not important)</returns>
    int getUiTrigger() const;

    /// <summary>
    /// Getter for the string list of side pots (amount and eligible players
    /// </summary>
    /// <returns>The string list of side pots</returns>
	QStringList getSidePots() const;

    // depricated
    QString getRaiseVal() const;

    /// <summary>
    /// Getter for the opacity of the increase button
    /// </summary>
    /// <returns>The opacity of the increase button</returns>
	double getRaiseUpOpacity() const;

    /// <summary>
    /// Getter for the opacity of the decrease button
    /// </summary>
    /// <returns>The opacity of the decrease button</returns>
    double getRaiseDownOpacity() const;

    /// <summary>
    /// Getter for the raising amount text
    /// </summary>
    /// <returns>The raising amount text</returns>
    QString getRaiseUpText() const;
#pragma endregion

#pragma region Methods available to QML
    /// <summary>
    /// (Q_INVOKABLE) Method allowing for connection to server
    /// </summary>
    /// <param name="ip">IP address (IPv4, IPv6, or COMPUTER_NAME.local if Windows 10/11)</param>
    /// <param name="port">Port as a string (max num: 2^16)</param>
    Q_INVOKABLE void connectToServer(const QString& ip, const QString& port);

    /// <summary>
    /// (Q_INVOKABLE) Method allowing for sending messages from QML
    /// </summary>
    /// <param name="msg">The message for server</param>
    Q_INVOKABLE void sendMessage_public(const QString& msg);

    /// <summary>
    /// (Q_INVOKABLE) Method allowing for name update
    /// </summary>
    /// <param name="name">The nickname</param>
    Q_INVOKABLE void updateName(const QString& name);

    /// <summary>
    /// (Q_INVOKABLE) Method for CHECK or CALL (or ALL-IN)
    /// </summary>
    Q_INVOKABLE void _match_bet();

    /// <summary>
    /// (Q_INVOKABLE) Method opening the raise bet box
    /// </summary>
    Q_INVOKABLE void _change_bet_open();

    /// <summary>
    /// (Q_INVOKABLE) Method for BET or RAISE
    /// </summary>
    Q_INVOKABLE void _change_bet_confirm();

    /// <summary>
    /// (Q_INVOKABLE) Method for FOLD
    /// </summary>
    Q_INVOKABLE void _fold();

    /// <summary>
    /// (Q_INVOKABLE) Method for increasing the bet
    /// </summary>
    Q_INVOKABLE void increaseBet();

    /// <summary>
    /// (Q_INVOKABLE) Method for decreasing the bet
    /// </summary>
    Q_INVOKABLE void decreaseBet();

    /// <summary>
    /// (Q_INVOKABLE) Getter for the player's name
    /// </summary>
    /// <param name="index">Index</param>
    /// <returns>The player's name</returns>
    Q_INVOKABLE QString getPlayerName(int index);

    /// <summary>
    /// (Q_INVOKABLE) Getter for the betting state (Small Blind, Big Blind, Normal)
    /// </summary>
    /// <param name="index">Index</param>
    /// <returns>The betting state</returns>
    Q_INVOKABLE QString getBettingState(int index);

    /// <summary>
    /// (Q_INVOKABLE) Getter for the balance
    /// </summary>
    /// <param name="index">Index</param>
    /// <returns>The balance</returns>
    Q_INVOKABLE QString getBalance(int index);

    /// <summary>
    /// (Q_INVOKABLE) Getter for the loans
    /// </summary>
    /// <param name="index">Index</param>
    /// <returns>The loans</returns>
    Q_INVOKABLE QString getLoans(int index);

    /// <summary>
    /// (Q_INVOKABLE) Getter for the current bet
    /// </summary>
    /// <param name="index">Index</param>
    /// <returns>The current bet</returns>
    Q_INVOKABLE QString getCurrentBet(int index);

    /// <summary>
    /// (Q_INVOKABLE) Getter for the acting player (i.e. if it's their turn)
    /// </summary>
    /// <param name="index">Index</param>
    /// <returns>The acting player</returns>
    Q_INVOKABLE QString getActingPlayer(int index);

    /// <summary>
    /// (Q_INVOKABLE) Getter for the background image (i.e. player's bg)
    /// </summary>
    /// <param name="index">Index</param>
    /// <returns>The background image</returns>
    Q_INVOKABLE QString getBackground(int index);

    /// <summary>
    /// (Q_INVOKABLE) Getter for the text color (for "Your turn" text)
    /// </summary>
    /// <param name="index">Index</param>
    /// <returns>The text color</returns>
    Q_INVOKABLE QString getTextColor(int index);

    /// <summary>
    /// (Q_INVOKABLE) Getter for the price color
    /// </summary>
    /// <param name="index">Index</param>
    /// <returns>The price color</returns>
    Q_INVOKABLE QString getPriceTextColor(int index);

    /// <summary>
    /// (Q_INVOKABLE) Getter for the left card as string
    /// </summary>
    /// <param name="index">Index</param>
    /// <returns>The left card as string</returns>
    Q_INVOKABLE QString getLeftCard(int index);

    /// <summary>
    /// (Q_INVOKABLE) Getter for the right card as string
    /// </summary>
    /// <param name="index">Index</param>
    /// <returns>The right card as string</returns>
	Q_INVOKABLE QString getRightCard(int index);

    /// <summary>
    /// (Q_INVOKABLE) Getter for the opacity of a plaer
    /// </summary>
    /// <param name="index">Index</param>
    /// <returns>The opacity of a player</returns>
	Q_INVOKABLE double getOpacity(int index);

    /// <summary>
    /// (Q_INVOKABLE) Getter for the side pots text (e.g. "Side pot 1: $100.00")
    /// </summary>
    /// <param name="index">Side pot own index</param>
    /// <returns>The side pots text</returns>
    Q_INVOKABLE QString getSidePotsText(int index);

    /// <summary>
    /// (Q_INVOKABLE) Getter for the available side pots (e.g. "M, 1, 2")
    /// </summary>
    /// <param name="index">Index</param>
    /// <returns>The available side pots</returns>
    Q_INVOKABLE QString getAvailablePots(int index);

#pragma region Margins
	// -- Logical checks for alignment options -- 
    /// <summary>
    /// (Q_INVOKABLE) Getter checking if a player box can be aligned to the top
    /// </summary>
    /// <param name="index">Index</param>
    /// <returns>True if can be aligned to the top; otherwise false</returns>
	Q_INVOKABLE bool canAlignTop(int index);

    /// <summary>
    /// (Q_INVOKABLE) Getter checking if a player box can be aligned to the bottom
    /// </summary>
    /// <param name="index">Index</param>
    /// <returns>True if can be aligned to the bottom; otherwise false</returns>
	Q_INVOKABLE bool canAlignBottom(int index);

    /// <summary>
    /// (Q_INVOKABLE) Getter checking if a player box can be aligned to the left
    /// </summary>
    /// <param name="index">Index</param>
    /// <returns>True if can be aligned to the left; otherwise false</returns>
	Q_INVOKABLE bool canAlignLeft(int index);

    /// <summary>
    /// (Q_INVOKABLE) Getter checking if a player box can be aligned to the right
    /// </summary>
    /// <param name="index">Index</param>
    /// <returns>True if can be aligned to the right; otherwise false</returns>
	Q_INVOKABLE bool canAlignRight(int index);
    // ---

	// -- Values for alignment options --
    /// <summary>
    /// (Q_INVOKABLE) Getter for the value of margin from the top
    /// </summary>
    /// <param name="index">Index</param>
    /// <returns>The value of top margin</returns>
	Q_INVOKABLE int getTopMargin(int index);

    /// <summary>
    /// (Q_INVOKABLE) Getter for the value of margin from the bottom
    /// </summary>
    /// <param name="index">Index</param>
    /// <returns>The value of bottom margin</returns>
	Q_INVOKABLE int getBottomMargin(int index);

    /// <summary>
    /// (Q_INVOKABLE) Getter for the value of margin from the left 
    /// </summary>
    /// <param name="index">Index</param>
    /// <returns>The value of left margin</returns>
	Q_INVOKABLE int getLeftMargin(int index);

    /// <summary>
    /// (Q_INVOKABLE) Getter for the value of margin from the right 
    /// </summary>
    /// <param name="index">Index</param>
    /// <returns>The value of right margin</returns>
	Q_INVOKABLE int getRightMargin(int index);
    // ---

    // -- Logical checks for Horizontal/Vertical alignments -- 
    /// <summary>
    /// (Q_INVOKABLE) Getter checking if a player box can be aligned horizontally
    /// </summary>
    /// <param name="index">Index</param>
    /// <returns>True if can be aligned horizontally; otherwise false</returns>
	Q_INVOKABLE bool canAlignHCenter(int index);

    /// <summary>
    /// (Q_INVOKABLE) Getter checking if a player box can be aligned vertically
    /// </summary>
    /// <param name="index">Index</param>
    /// <returns>True if can be aligned vertically; otherwise false</returns>
	Q_INVOKABLE bool canAlignVCenter(int index);
    // ---
#pragma endregion
#pragma endregion

	// public members
    QString m_ipAddress;
    QString m_port;
    QString m_clientName;

#pragma region Signals (I'd call it triggerers)
signals:
    void statusChanged();
    void connectedToServer();
    void lobbyReady();
    void connectionDetailsChanged();
	void nameProblemTriggered();
    void updatedName();
    void updatedLobbySize();
    void gameReady();
    void playerListChanged();
    void updatedGamePage();
    void raiseValueChanged();
	void connectionError(const QString& errorMsg);
#pragma endregion

private:
	// private members
    QTcpSocket* m_socket;
    QString m_status;
	QString m_nameProblem;
    bool hasConnected = false;
    QStringList m_playerList;
    QString m_buffer;
    int m_uiTrigger;
    int m_raiseVal;
	QStringList m_sidePots;

    /*
	    so those booleans were originally to make sure that the update only happens
	    after all parts of the game state have been received
	    however, due to the asynchronous nature of Qt signals and slots,
	    this approach was unreliable and has been deprecated, because
		the bytes are read until '\n' is found, and each complete message is processed immediately
    */
    bool gotPlayers;
    //bool gotGameInfo;
    //bool gotCommunityCards;
    //bool gotPlayerCards;

    /// <summary>
    /// Method for setting the connection status (so this shows the error when something failed)
    /// </summary>
    /// <param name="msg">The message of the status</param>
    void setStatus(const QString& msg);

    /// <summary>
    /// Method for setting the name problem (i.e. someone with a certain nickname already exists)
    /// </summary>
    /// <param name="msg">The message of the name problem</param>
	void setNameProblem(const QString& msg);

    /// <summary>
    /// Method for sending a message to server
    /// </summary>
    /// <param name="msg">The message to be sent</param>
	void sendMessage(const QString& msg);

    /// Receives data from server
	void onReadyRead();

    /// <summary>
    /// Processes a single complete message from the buffer
    /// </summary>
    /// <param name="msg">The message from the buffer</param>
    void processBuffer(const QString& msg);

    /// Updates the UI
    void _update();

    /// Sets the current acting player if possible
    void nextPlayer();
};
