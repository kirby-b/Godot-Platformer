extends Node

# Controls signals for events
signal player_hurt # Signals the player losing a piece of life
signal player_died # Signals a player death
signal checkpoint(checkpoint_position) # Signals that the player got a checkpoint
signal coin_get # Signals the player getting a coin
signal diamond_get # Signals the player getting a diamond (5 coins)
signal respawn # Signals a player respawning
signal sink_finish # Signals the player has sank
