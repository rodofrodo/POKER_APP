#pragma once

#include <QString>
#include "../enums/GameEnums.h"
#include "GameCard.h"
#include "../general/poker_structs.h"

class Player
{
public:
	QString name;
	int balance;
	bool isDealer;
	BettingState bettingState;
	GameCard leftCard;
	GameCard rightCard;
	TUPLE::Bet currentBet;
	bool hasFolded;
	int loans;
	bool hasWon;
	QString winningHandString;
	// -- constructor --
	Player() : name(""), balance(0), isDealer(false), bettingState(BettingState::NORMAL),
		leftCard(Suit::CLUBS, Rank::TWO), rightCard(Suit::CLUBS, Rank::TWO),
		hasFolded(false), loans(0), hasWon(false), winningHandString("") {}
	// ---
	bool operator==(const Player& other) const;
};
