// main implementation file for the GameCard class
#include "GameCard.h"

GameCard::GameCard(Suit suit, Rank rank)
{
	this->suit = suit;
	this->rank = rank;
}

// maybe it's not needed after all
// but if I remove it, it gives me an error
GameCard::GameCard() {}

bool GameCard::operator==(const GameCard& other) const
{
	return rank == other.rank && suit == other.suit;
}

std::string GameCard::getRankString(Rank rank) const
{
	if (rank == Rank::TWO) return "2";
	else if (rank == Rank::THREE) return "3";
	else if (rank == Rank::FOUR) return "4";
	else if (rank == Rank::FIVE) return "5";
	else if (rank == Rank::SIX) return "6";
	else if (rank == Rank::SEVEN) return "7";
	else if (rank == Rank::EIGHT) return "8";
	else if (rank == Rank::NINE) return "9";
	else if (rank == Rank::TEN) return "10";
	else if (rank == Rank::JACK) return "J";
	else if (rank == Rank::QUEEN) return "Q";
	else if (rank == Rank::KING) return "K";
	else if (rank == Rank::ACE) return "A";
	return "bla bla bla";
}

std::string GameCard::toString() const
{
	std::string result;
	/*if (suit == Suit::HEARTS) result = reinterpret_cast<const char*>(u8"\u2665");
	else if (suit == Suit::DIAMONDS) result = reinterpret_cast<const char*>(u8"\u2666");
	else if (suit == Suit::CLUBS) result = reinterpret_cast<const char*>(u8"\u2663");
	else if (suit == Suit::SPADES) result = reinterpret_cast<const char*>(u8"\u2660");*/
	switch (suit)
	{
	case Suit::HEARTS: result = "HEARTS_"; break;
	case Suit::DIAMONDS: result = "DIAMONDS_"; break;
	case Suit::CLUBS: result = "CLUBS_"; break;
	case Suit::SPADES: result = "SPADES_"; break;
	default: result = "-"; break;
	}
	result += getRankString(rank);
	return result;
}
