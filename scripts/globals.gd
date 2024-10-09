#extends Node2D
#
##Novos sinais 
#signal coins_updated
#signal score_updated
#signal life_updated
#
##Setters
#
#var coins := 0
#var score : =0
#var player_life := 1
#
#var player = null
#
#var current_checkpoint = null
#
#func respawn_player():
	#if current_checkpoint != null:
		#player.position = current_checkpoint.global_position
