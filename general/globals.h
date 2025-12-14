#pragma once
#include <QString>
#include <vector>
#include <map>
#include "general/poker_structs.h"
#include "enums/GameEnums.h"
#include "classes/Player.h"

// -- main game --
extern int playerInLobby;
extern GameState currentGameState;
extern BettingRound currentBettingRound;
extern size_t currentPlayer;
extern size_t clientIndex;
extern QString clientName;
extern int pot;
extern std::vector<QString> playerNames;
extern std::map<QString, Player> playerMap;
extern std::vector<GameCard> communityCards;
extern TUPLE::Bet topbet;
extern int minimalRaiseAmount;

// -- winner --
extern std::vector<std::vector<GameCard>> globalWinningCards;
extern std::vector<size_t> globalWinningCardsSize;
extern std::vector<QString> globalWinningMsg;
extern QString globalWinningType;

// -- default winner --
// i.e. the one who won because other have folded
extern QString globalDefaultWinner;

// side pots
extern std::vector<std::pair<int, std::vector<QString>>> sidePots; // amount, players involved
