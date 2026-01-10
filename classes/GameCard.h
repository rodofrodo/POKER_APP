#pragma once

// necessary includes
#include "../enums/GameEnums.h"
#include <string>

class GameCard
{
private:
	Suit suit;
	Rank rank;

	/// <summary>Converts a Rank enum value to its string representation.</summary>
	/// <param name="rank">The rank value to convert.</param>
	/// <returns>The uppercase string name of the rank (e.g. "ACE", "KING").</returns>
	std::string getRankString(Rank rank) const;
public:
	/// <summary>
	/// IT HAS TO BE THERE FOR SOME REASON.
	/// </summary>
	GameCard();

	/// <summary>Constructs a GameCard with the given suit and rank.</summary>
	/// <param name="suit">The suit of the card.</param>
	/// <param name="rank">The rank of the card.</param>
	GameCard(Suit suit, Rank rank);

	/// <summary>Creates a string representation of the GameCard as "SUIT%RANK".</summary>
	/// <param name="(none)">No parameters.</param>
	/// <returns>A string combining suit and rank, e.g. "HEARTS%ACE".</returns>
	std::string toString() const;

	// getters
	Rank getRank() const { return rank; }
	Suit getSuit() const { return suit; }

	/// <summary>Compares this GameCard to another for equality (same rank and suit).</summary>
	/// <param name="other">The other GameCard to compare against.</param>
	/// <returns>True if both rank and suit are equal; otherwise false.</returns>
	bool operator==(const GameCard& other) const;
};
