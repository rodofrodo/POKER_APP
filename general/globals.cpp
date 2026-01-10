#include "globals.h"
#include "bet_expressions.h"

// -- main game --
int playerInLobby = 0;
GameState currentGameState = GameState::WAITING_FOR_PLAYERS;
BettingRound currentBettingRound = BettingRound::PRE_FLOP;
size_t currentPlayer = 2; // big blind + 1, as they'll put a bet automatically
size_t clientIndex;
QString clientName;
int pot = 0;
std::vector<QString> playerNames;
std::map<QString, Player> playerMap;
std::vector<GameCard> communityCards;
TUPLE::Bet topbet{ VAL::CLEAR, false };
int RAINBOW[12] = { 0x04, 0x0C, 0x06, 0x0E, 0x02, 0x0A, 0x0B, 0x03, 0x01, 0x09, 0x0D, 0x05 }; // those who know
int minimalRaiseAmount = 500; // $5.00

// -- winner --
std::vector<std::vector<GameCard>> globalWinningCards;
std::vector<size_t> globalWinningCardsSize;
std::vector<QString> globalWinningMsg;
QString globalWinningType;

// -- default winner --
QString globalDefaultWinner;

// side pots
std::vector<std::pair<int, std::vector<QString>>> sidePots; // amount, players involved
