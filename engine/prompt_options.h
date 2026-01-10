#pragma once

// necessary includes
#include <QStringList>
#include <string>
#include <format>
#include <utility>
#include "../general/poker_structs.h"
#include "../classes/Player.h"
#include "general/bet_expressions.h"

namespace prompt
{
    /// <summary>
	/// It served a different purpose before, now it just returns min and max raise amounts
    /// </summary>
    /// <param name="highestBet">The highest bet</param>
    /// <param name="sender">The player's name</param>
    /// <returns>Minimum and maximum value for raise</returns>
    inline TUPLE::MinMax getDifferentBetOptions(TUPLE::Bet highestBet, Player sender)
    {
        int highbet = (highestBet.value == VAL::CLEAR) ? VAL::EMPTY : highestBet.value;
        int senderbet = (sender.currentBet.value == VAL::CLEAR) ? VAL::EMPTY : sender.currentBet.value;
        int val_min = (highbet + minimalRaiseAmount); // minimal raise, e.g. +$5.00
        int val_max = sender.balance + sender.currentBet.value; // !!!
        double val_min_double = static_cast<double>(val_min) / 100.0;
        double val_max_double = static_cast<double>(val_max) / 100.0;
        return { val_min, val_max };
    }

    /// <summary>
	/// Gives you the available options for the player based on the highest bet and their current bet
    /// </summary>
    /// <param name="highestBet">The highest bet</param>
    /// <param name="sender">The player's name</param>
    /// <returns>A list of available options</returns>
    inline QStringList getAvailableOptions(TUPLE::Bet highestBet, Player sender)
    {
        int highbet = (highestBet.value == VAL::CLEAR) ? VAL::EMPTY : highestBet.value;
        int senderbet = (sender.currentBet.value == VAL::CLEAR) ? VAL::EMPTY : sender.currentBet.value;
        int val = highbet - senderbet;
        bool all_in = highestBet.isAllIn;
        QStringList r;
        // ---
        double x = val / 100.0;
        if (sender.balance <= val)
        {
            r.append("All-in");
            r.append("-");
        }
        else
        {
            r.append((val != VAL::EMPTY) ? "Call ($" + QString::number(x, 'f', 2) + ")" : "Check");
			TUPLE::MinMax raiseOpts = getDifferentBetOptions(highestBet, sender);
            if (raiseOpts.min > sender.balance)
                r.append("-");
			else
                r.append((highbet != VAL::EMPTY) ? "Raise" : "Bet");
        }
        r.append("Fold");
        return r;
    }
}

