extends Node

var coins := 0
var score := 0
var player_life = 1

var player = null

var current_chekpoint = null

func respawn_player():
	if current_chekpoint != null:
		player.position = current_chekpoint
		globals.player.set_physics_process(true)
