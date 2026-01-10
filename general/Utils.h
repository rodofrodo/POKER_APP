#pragma once

// necessary includes
#include <QString>
#include <string>
#include <vector>
#include <sstream>
#include <utility>
#include "../classes/GameCard.h"

namespace utils
{
    /// <summary>
    /// Checks whether the given string 'str' starts with the prefix 'prefix'.
    /// </summary>
    /// <param name="str">Input string in which the prefix is checked.</param>
    /// <param name="prefix">Prefix to compare with the beginning of 'str'.</param>
    /// <returns>True if 'str' starts with 'prefix', otherwise false.</returns>
    inline bool startsWith(const std::string& str, const std::string& prefix)
    {
        // check if 'str' starts with 'prefix'
        return str.size() >= prefix.size() && str.compare(0, prefix.size(), prefix) == 0;
    }

    /// <summary>
    /// Splits the string 'str' into tokens using the separator 'delimiter'.
    /// </summary>
    /// <param name="str">Input string</param>
    /// <param name="delimiter">The character used as a separator</param>
    /// <returns>A vector of QStrings</returns>
    inline std::vector<QString> split(const std::string& str, char delimiter)
    {
        std::vector<QString> tokens;
        std::stringstream ss(str);
        std::string item;
        while (std::getline(ss, item, delimiter)) tokens.push_back(QString::fromStdString(item));
        return tokens;
    }

    /// <summary>
	/// Converts a string representation of a card into a GameCard object.
    /// </summary>
    /// <param name="cardStr">A string of a card</param>
    /// <returns>The GameCard object</returns>
    inline GameCard parseCard(const std::string& cardStr)
    {
        // Expected format: "Suit%Rank", e.g., "HEARTS%ACE"
        std::vector<QString> parts = split(cardStr, '%');
        if (parts.size() != 2) throw std::invalid_argument("Invalid card format");
        Suit suit;
        Rank rank;
        // Parse suit
        if (parts[0] == "HEARTS") suit = Suit::HEARTS;
        else if (parts[0] == "DIAMONDS") suit = Suit::DIAMONDS;
        else if (parts[0] == "CLUBS") suit = Suit::CLUBS;
        else if (parts[0] == "SPADES") suit = Suit::SPADES;
        else throw std::invalid_argument("Invalid suit");
        // Parse rank
        if (parts[1] == "TWO") rank = Rank::TWO;
        else if (parts[1] == "THREE") rank = Rank::THREE;
        else if (parts[1] == "FOUR") rank = Rank::FOUR;
        else if (parts[1] == "FIVE") rank = Rank::FIVE;
        else if (parts[1] == "SIX") rank = Rank::SIX;
        else if (parts[1] == "SEVEN") rank = Rank::SEVEN;
        else if (parts[1] == "EIGHT") rank = Rank::EIGHT;
        else if (parts[1] == "NINE") rank = Rank::NINE;
        else if (parts[1] == "TEN") rank = Rank::TEN;
        else if (parts[1] == "JACK") rank = Rank::JACK;
        else if (parts[1] == "QUEEN") rank = Rank::QUEEN;
        else if (parts[1] == "KING") rank = Rank::KING;
        else if (parts[1] == "ACE") rank = Rank::ACE;
        else throw std::invalid_argument("Invalid rank");
        return GameCard(suit, rank);
    }

    /// <summary>
	/// Converts a PokerHand enum value to its corresponding string representation.
    /// </summary>
    /// <param name="pk">A PokerHand value</param>
    /// <returns>The poker hand string</returns>
    inline std::string getHandName(PokerHand pk)
    {
        switch (pk)
        {
        case PokerHand::ROYAL_FLUSH: return "Royal flush";
        case PokerHand::STRAIGHT_FLUSH: return "Straight flush";
        case PokerHand::FOUR_OF_A_KIND: return "Four of a kind";
        case PokerHand::FULL_HOUSE: return "Full house";
        case PokerHand::FLUSH: return "Flush";
        case PokerHand::STRAIGHT: return "Straight";
        case PokerHand::THREE_OF_A_KIND: return "Three of a kind";
        case PokerHand::TWO_PAIR: return "Two pair";
        case PokerHand::ONE_PAIR: return "One pair";
        case PokerHand::HIGH_CARD: return "High card";
        default: throw std::invalid_argument("Invalid poker hand");
        }
    }

    /// <summary>
	/// Converts a BettingRound enum value to its corresponding string representation.
    /// </summary>
    /// <param name="br">A BettingRound value</param>
    /// <returns>The betting round string</returns>
    inline std::string getBettingRound(BettingRound br)
    {
        switch (br)
        {
        case BettingRound::PRE_FLOP: return "PRE-FLOP";
        case BettingRound::FLOP: return "FLOP";
        case BettingRound::TURN: return "TURN";
        case BettingRound::RIVER: return "RIVER";
        default: throw std::invalid_argument("Invalid round");
        }
    }

    /// <summary>
	/// Converts an integer to its Roman numeral representation.
    /// </summary>
    /// <param name="number">A number</param>
    /// <returns>A string with a Roman numeral</returns>
    inline std::string getRomanNumeral(int number)
    {
        std::string roman;
        std::pair<int, std::string> valueMap[] = {
            {1000, "M"}, {900, "CM"}, {500, "D"}, {400, "CD"},
            {100, "C"}, {90, "XC"}, {50, "L"}, {40, "XL"},
            {10, "X"}, {9, "IX"}, {5, "V"}, {4, "IV"},
            {1, "I"}
        };
        for (const auto& [value, symbol] : valueMap)
        {
            while (number >= value)
            {
                roman += symbol;
                number -= value;
            }
        }
        return roman;
    }
}
