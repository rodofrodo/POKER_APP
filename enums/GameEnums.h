#pragma once

/// Game cycle states: waiting, dealing, betting rounds, showdown and game over.
enum class GameState
{
	WAITING_FOR_PLAYERS,
	DEALING_CARDS,
	BETTING_ROUND,
	SHOWDOWN,
	GAME_OVER
};

/// Sequential betting rounds in a poker hand: pre-flop, flop, turn, river.
enum class BettingRound
{
	PRE_FLOP,
	FLOP,
	TURN,
	RIVER
};

/// Forced bet state: small blind, big blind or normal play without forced blinds.
enum class BettingState
{
	SMALL_BLIND, BIG_BLIND, NORMAL
};

/// Card suits in the deck: hearts, diamonds, clubs, spades (values start at 1).
enum class Suit { HEARTS, DIAMONDS, CLUBS, SPADES };

/// Card ranks from 2 to A (numeric values start at 2).
enum class Rank { TWO = 2, THREE, FOUR, FIVE, SIX, SEVEN, EIGHT, NINE, TEN, JACK, QUEEN, KING, ACE };

/// Poker hand categories in ascending strength order (HIGH_CARD = 1).
enum class PokerHand
{
	HIGH_CARD = 1, ONE_PAIR, TWO_PAIR, THREE_OF_A_KIND, STRAIGHT, FLUSH, FULL_HOUSE, FOUR_OF_A_KIND,
	STRAIGHT_FLUSH, ROYAL_FLUSH
};
