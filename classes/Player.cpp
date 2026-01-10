// main implementation file for the Player class
#include "Player.h"

bool Player::operator==(const Player& other) const
{
	// lmao
	return name == other.name;
}
