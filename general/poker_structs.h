#pragma once

namespace TUPLE
{
	/// Represents a bet: the amount and whether it is an all-in.
	struct Bet
	{
		int value = 0;
		bool isAllIn = false;
	};

	/// A struct to hold minimum and maximum values.
	struct MinMax
	{
		int min;
		int max;
	};
}
