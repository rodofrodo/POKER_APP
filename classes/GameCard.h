#pragma once

// necessary includes
#include "../enums/GameEnums.h"
#include <string>

class GameCard
{
private:
	Suit suit;
	Rank rank;
	std::string getRankString(Rank rank) const;
public:
	GameCard();
	GameCard(Suit suit, Rank rank);
	std::string toString() const;
	Rank getRank() const { return rank; }
	Suit getSuit() const { return suit; }
	bool operator==(const GameCard& other) const;
};
