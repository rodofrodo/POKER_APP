#include "backend.h"
#include "general/globals.h"
#include "general/bet_expressions.h"
#include <vector>
#include "general/Utils.h"
#include "classes/GameCard.h"
#include "general/poker_structs.h"
#include "enums/GameEnums.h"
#include <format>

const QString INFO_MSG_PREFIX = "Connected";
const QString LENGTH_MSG_PREFIX = "Length";
const QString BROADCAST_MSG_PREFIX = "Broadcast";
const QString DISCONNECT_MSG_PREFIX = "Disconnected";
const QString START_GAME_MSG_PREFIX = "StartGame";
const QString BETTING_ORDER_MSG_PREFIX = "Bettings";
const QString COMMUNITY_CARDS_MSG_PREFIX = "CommunityCards";
const QString PLAYER_CARDS_MSG_PREFIX = "PlayerCards";
const QString WINNER_HAND_MSG_PREFIX = "WinnerHand";
const QString DEFAULT_WINNER_MSG_PREFIX = "DefaultWinner";
const QString SIDE_POTS_MSG_PREFIX = "SidePots";
const QString NEW_BET_MSG_PREFIX = "NewBet";
const QString BANKRUPTS_MSG_PREFIX = "Bankrupts";

Backend::Backend(QObject* parent) : QObject(parent), m_socket(new QTcpSocket(this))
{
    m_status = "Ready to connect.";

    // Listen for socket state changes
    connect(m_socket, &QTcpSocket::connected, this, [this]() {
        setStatus("Connected successfully!");
        emit connectedToServer();
        });

    connect(m_socket, &QTcpSocket::disconnected, this, [this]() {
        setStatus("Disconnected from server.");
		});

	connect(m_socket, &QTcpSocket::readyRead, this, &Backend::onReadyRead);

    connect(m_socket, &QTcpSocket::errorOccurred, this, [this](QAbstractSocket::SocketError) {
        setStatus("Error: " + m_socket->errorString());
        });
}

QString Backend::statusMessage() const
{
    return m_status;
}

void Backend::setStatus(const QString& msg)
{
    if (m_status != msg) {
        m_status = msg;
        emit statusChanged();
    }
}

void Backend::connectToServer(const QString& ip, const QString& port)
{
    if (m_socket->state() == QAbstractSocket::ConnectedState)
    {
        m_socket->disconnectFromHost();
    }

    setStatus("Connecting...");
    // Convert string port to integer
    bool ok;
    int portInt = port.toInt(&ok);

    if (ok)
    {
        m_socket->connectToHost(ip, portInt);
        m_ipAddress = ip;
        m_port = port;
        emit connectionDetailsChanged();
    }
    else
    {
        setStatus("Invalid Port Number");
    }
}

void Backend::sendMessage_public(const QString& msg)
{
    sendMessage(msg);
}

void Backend::sendMessage(const QString& msg)
{
    if (m_socket->state() == QAbstractSocket::ConnectedState)
    {
        QString mm = msg + "\n";
        QByteArray data = mm.toUtf8();
        m_socket->write(data);
    }
    else
    {
        setStatus("Not connected to server.");
    }
}

void Backend::onReadyRead()
{
    QByteArray data = m_socket->readAll();
    m_buffer += QString::fromUtf8(data);
    while (m_buffer.contains('\n'))
    {
        int endIndex = m_buffer.indexOf('\n');
        QString singleMessage = m_buffer.left(endIndex);
        m_buffer.remove(0, endIndex + 1);
        processBuffer(singleMessage);
    }
}

void Backend::processBuffer(const QString& msg)
{
    if (msg.startsWith(LENGTH_MSG_PREFIX))
    {
        QStringList parts = msg.split("&");
        if (parts.size() == 3)
        {
            bool ok;
            int length = parts[1].toInt(&ok);
            QStringList players = parts[2].split("#");
            if (ok)
            {
                if (!hasConnected)
                {
                    hasConnected = true;
                    emit lobbyReady();
                }
                m_playerList = players;
                playerInLobby = length;
                emit updatedLobbySize();
                emit playerListChanged();
            }
        }
    }
    else if (msg.startsWith(DISCONNECT_MSG_PREFIX))
        sendMessage("len");
    else if (msg.startsWith(START_GAME_MSG_PREFIX))
    {
        if (hasConnected)
            emit gameReady();
        currentGameState = GameState::DEALING_CARDS;
        pot = 0;
        topbet = { VAL::CLEAR, false };
        sidePots.clear();
        QStringList parts = msg.split("&");
        if (parts.size() < 2) return; // SAFETY CHECK
        QString playerList = msg.split("&")[1];
        QStringList playerProps = playerList.split("#");
        playerMap.clear();
        playerNames.clear();
        size_t index = 0;
        for (const QString& prop : playerProps)
        {
            QStringList details = prop.split("*");
            if (details.size() < 2) continue;
            Player p;
            p.name = details[0];
            p.balance = details[1].toInt();
            p.loans = details[2].toInt();
            p.bettingState = BettingState::NORMAL;
            p.isDealer = false;
            p.leftCard = GameCard(Suit::CLUBS, Rank::TWO);
            p.rightCard = GameCard(Suit::CLUBS, Rank::TWO);
            p.currentBet = { VAL::CLEAR, false };
            p.hasFolded = false;
            playerMap[p.name] = p;
            playerNames.push_back(p.name);
            if (clientName == p.name)
                clientIndex = index;
            index++;
        }
    }
    else if (msg.startsWith(BETTING_ORDER_MSG_PREFIX))
    {
        QStringList parts = msg.split("&");
        if (parts.size() < 2) return; // Check main split
        QStringList bettings = parts[1].split("#");
        for (int i = 0; i < bettings.size(); i++)
        {
            for (int j = 0; j < playerMap.size(); j++)
            {
                QStringList betParts = bettings[i].split(":");
                if (betParts.size() < 2) continue; // Skip bad data
                QString what = betParts[0];
                QString name = betParts[1];
                if (playerNames[j] == name)
                {
                    if (what == "Dealer")
                    {
                        playerMap[playerNames[j]].isDealer = true;
                        playerMap[playerNames[j]].bettingState = BettingState::NORMAL;
                    }
                    else if (what == "SmallBlind")
                        playerMap[playerNames[j]].bettingState = BettingState::SMALL_BLIND;
                    else if (what == "BigBlind")
                    {
                        playerMap[playerNames[j]].bettingState = BettingState::BIG_BLIND;
                        currentPlayer = j;
                    }
                    else
                        playerMap[playerNames[j]].bettingState = BettingState::NORMAL;
                }
            }
        }
        currentBettingRound = BettingRound::PRE_FLOP;
        nextPlayer();
        gotPlayers = true;
        gotGameInfo = true;
    }
    else if (msg.startsWith(COMMUNITY_CARDS_MSG_PREFIX))
    {
        QStringList parts = msg.split("&");
        if (parts.size() < 2) return;
        QString cardsData = parts[1];
        QStringList cardStrs = cardsData.split("#");
        communityCards.clear();
        for (const QString & cardStr : cardStrs)
        {
            GameCard card = utils::parseCard(cardStr.toStdString());
            communityCards.push_back(card);
        }
        gotCommunityCards = true;
    }
    else if (msg.startsWith(PLAYER_CARDS_MSG_PREFIX))
    {
        QStringList parts = msg.split("&");
        if (parts.size() < 2) return;
        QString cardsData = parts[1];
        QStringList cardStrs = cardsData.split("+");
        for (const QString& cardStr : cardStrs)
        {
            QStringList mini_info = cardStr.split("#");
            QString name = mini_info[0];
            QString left_card = mini_info[1].split("=")[0];
            QString right_card = mini_info[1].split("=")[1];
            playerMap[name].leftCard = utils::parseCard(left_card.toStdString());
            playerMap[name].rightCard = utils::parseCard(right_card.toStdString());
        }
        gotPlayerCards = true;
        // ---
        for (auto& [k, p] : playerMap)
        {
            if (p.bettingState == BettingState::SMALL_BLIND)
            {
                p.balance -= 500;
                pot += 500;
                p.currentBet = { 500, false };
            }
            if (p.bettingState == BettingState::BIG_BLIND)
            {
                p.balance -= 1000;
                pot += 1000;
                topbet = { 1000, false };
                p.currentBet = topbet;
                currentGameState = GameState::BETTING_ROUND;
            }
        }
    }
    else if (msg.startsWith(WINNER_HAND_MSG_PREFIX))
    {
        globalWinningCards.clear();
        globalWinningCardsSize.clear();
        globalWinningMsg.clear();
        QStringList parts = msg.split("&");
        for (const QString& p : parts)
        {
            if (p == WINNER_HAND_MSG_PREFIX) continue;
            if (p == "normal" || p == "sidepot")
            {
                globalWinningType = p;
                continue;
            }
            QStringList info = p.split("=");
            if (info.size() < 3) continue;
            // ---
            QString winnerName = info[0];
            PokerHand winningHand = (PokerHand)info[1].toInt();
            QStringList cardsStrs = info[2].split("#");
            std::vector<GameCard> winningCards;
            for (const QString& cardStr : cardsStrs)
            {
                GameCard card = utils::parseCard(cardStr.toStdString());
                winningCards.push_back(card);
            }
            std::string message = std::format("The winner is: {}\nWon with: {}",
                winnerName.toStdString(), utils::getHandName(winningHand));
            globalWinningCards.push_back(winningCards);
            globalWinningCardsSize.push_back(winningCards.size());
            globalWinningMsg.push_back(QString::fromStdString(message));
        }
    }
    else if (msg.startsWith(DEFAULT_WINNER_MSG_PREFIX))
    {
        auto parts = msg.split("&");
        if (parts.size() < 2) return;
        globalDefaultWinner = parts[1];
    }
    else if (msg.startsWith(SIDE_POTS_MSG_PREFIX))
    {
        sidePots.clear();
        auto parts = msg.split("&");
        if (parts.size() < 2) return;
        auto info = parts[1].split("|");
        for (const auto& potInfo : info)
        {
            auto potParts = potInfo.split("=");
            if (potParts.size() < 2) continue;
            int amount = potParts[0].toInt();
            std::vector<QString> playersInvolved = utils::split(potParts[1].toStdString(), '#');
            sidePots.push_back({ amount, playersInvolved });
        }
    }
    else if (msg.startsWith(NEW_BET_MSG_PREFIX))
    {
        auto parts = msg.split("&");
        if (parts.size() < 2) return;
        auto info = parts[1].split("=");
        if (info.size() < 4) return;
        for (auto& [key, p] : playerMap)
        {
            if (p.name == info[0])
            {
                int currBet = info[1].toInt();
                int mode = info[2].toInt();
                int prevBet = (p.currentBet.value == VAL::CLEAR) ? VAL::EMPTY : p.currentBet.value;
                int prevTopbet = (topbet.value == VAL::CLEAR) ? VAL::EMPTY : topbet.value;
                p.currentBet = { currBet, false };
                if (currBet != 0 && currBet >= topbet.value)
                    topbet = p.currentBet;
                // ---
                int calc;
                if (mode == 1)
                    calc = (currBet - prevBet);
                else if (mode == 2)
                {
                    calc = (currBet - prevBet);
                    minimalRaiseAmount = (currBet - prevTopbet);
                }
                else if (mode == 3)
                {
                    p.hasFolded = true;
                    break;
                }
                else if (mode == 4)
                {
                    calc = p.balance; // all-in
                    p.currentBet = { currBet, true };
                }
                else
                    calc = 0;
                p.balance -= calc;
                pot += calc;
            }
        }
        bool all_equal = info[3] == "true";
        if (!all_equal)
            nextPlayer();
        else
        {
            topbet = { VAL::CLEAR, false };
            minimalRaiseAmount = 500; // reset minimal raise amount
            // checking if ended by folding
            int inGame = 0, hasNotGoneAllIn = 0;
            for (const auto& v : playerNames)
            {
                if (!playerMap[v].hasFolded)
                    inGame++;
                if (!playerMap[v].hasFolded && !playerMap[v].currentBet.isAllIn)
                    hasNotGoneAllIn++;
            }
            if (inGame < 2)
            {
                currentGameState = GameState::GAME_OVER;
                sendMessage(QString::fromStdString("get_winner&game_over&" + std::to_string(pot)));
                return;
            }
            // ---
            currentBettingRound = (BettingRound)((int)currentBettingRound + 1);
            if ((int)currentBettingRound > 3 || hasNotGoneAllIn < 2)
            {
                currentGameState = GameState::SHOWDOWN;
                sendMessage(QString::fromStdString("get_winner&showdown&" + std::to_string(pot)));
                return;
            }
            // ---
            for (int i = 0; i < playerMap.size(); i++)
            {
                QString name = playerNames[i];

                // 2. Safety: Ensure this name actually exists in the map
                if (playerMap.find(name) == playerMap.end()) continue;

                // 3. Logic
                if (playerMap[name].bettingState == BettingState::SMALL_BLIND)
                {
                    currentPlayer = i;

                    // Check if we need to skip this player (Folded or All-In)
                    if (playerMap[name].hasFolded ||
                        playerMap[name].currentBet.isAllIn)
                    {
                        nextPlayer();
                    }
                    break; // Found the small blind, stop looking
                }
                /*if (playerMap[playerNames[i]].bettingState == BettingState::SMALL_BLIND)
                {
                    currentPlayer = i;
                    if (playerMap[playerNames[i]].hasFolded ||
                        playerMap[playerNames[i]].currentBet.isAllIn)
                    {
                        nextPlayer();
                        break;
                    }
                }*/
            }
            for (auto& [key, p] : playerMap)
            {
                if (p.currentBet.isAllIn) continue;
                p.currentBet = topbet;
            }
        }
    }
    else if (msg.startsWith(BANKRUPTS_MSG_PREFIX))
    {
        auto parts = msg.split("&");
        if (parts.size() < 2) return;
        auto info = parts[1].split("#");
        for (const auto& name : info)
        {
            playerMap[name].balance = 100000;
            playerMap[name].loans++;
        }
    }
    if (gotPlayers)
        _update();
}

void Backend::_update()
{

    emit updatedGamePage();
}

void Backend::updateName(const QString& name)
{
    m_clientName = name;
    emit updatedName();
}

void Backend::nextPlayer()
{
    if (playerNames.empty())
    {
        qDebug() << "CRITICAL: nextPlayer called with empty player list!";
        return;
    }

    int attempts = 0;
    int maxAttempts = playerNames.size();

    do
    {
        currentPlayer = (currentPlayer + 1) % playerNames.size();
        QString name = playerNames[currentPlayer];
        bool isFolded = playerMap[name].hasFolded;
        bool isAllIn = playerMap[name].currentBet.isAllIn;
        if (!isFolded && !isAllIn)
            return;
        attempts++;
    } while (attempts < maxAttempts);

    qDebug() << "WARNING: No active players found (everyone folded or all-in).";
    /*currentPlayer = (currentPlayer + 1) % playerMap.size();
    if (playerMap[playerNames[currentPlayer]].hasFolded ||
        playerMap[playerNames[currentPlayer]].currentBet.isAllIn)
        nextPlayer();*/
}

void Backend::_match_bet()
{
    if (m_clientName == playerNames[currentPlayer])
    {
        int highbet = (topbet.value == VAL::CLEAR)
            ? VAL::EMPTY
            : topbet.value;
        int senderbet = (playerMap[playerNames[currentPlayer]].currentBet.value == VAL::CLEAR)
            ? VAL::EMPTY
            : playerMap[playerNames[currentPlayer]].currentBet.value;
        int val = highbet - senderbet;
        if (playerMap[playerNames[currentPlayer]].balance <= val) // !!!
        {
            // all-in
            sendMessage(QString::fromStdString(std::format("action&{}={}={}",
                m_clientName.toStdString(), 4, playerMap[playerNames[currentPlayer]].balance)));
            return;
        }
        sendMessage(QString::fromStdString(std::format("action&{}={}={}",
            m_clientName.toStdString(), 1, val)));
    }
}

void Backend::_change_bet_open()
{
    if (m_clientName == playerNames[currentPlayer])
    {
        TUPLE::MinMax res = prompt::getDifferentBetOptions(topbet, playerMap[playerNames[currentPlayer]]);
        m_raiseVal = res.min;
        emit raiseValueChanged();
    }
}

void Backend::_change_bet_confirm()
{
    if (m_clientName == playerNames[currentPlayer])
    {
        TUPLE::MinMax res = prompt::getDifferentBetOptions(topbet, playerMap[playerNames[currentPlayer]]);
        if (m_raiseVal >= res.max)
        {
            sendMessage(QString::fromStdString(std::format("action&{}={}={}",
                m_clientName.toStdString(), 4, playerMap[playerNames[currentPlayer]].balance)));
        }
        sendMessage(QString::fromStdString(std::format("action&{}={}={}",
            m_clientName.toStdString(), 2, m_raiseVal)));
    }
}

void Backend::_fold()
{
    if (m_clientName == playerNames[currentPlayer])
        sendMessage(QString::fromStdString(std::format("action&{}={}={}",
            m_clientName.toStdString(), 3, -123456)));
}
