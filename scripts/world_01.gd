extends Node2D

@onready var player := $player as CharacterBody2D
@onready var player_scene = preload("res://Actors/player.tscn")
@onready var camera := $camera as Camera2D

func _ready() -> void:
	globals.player = player
	globals.player.follow_camera(camera)
	globals.player.player_has_died.connect(reload_game)
	#control.time_is_up.connect(reload_game)
	globals.coins = 0
	globals.score = 0
	globals.player_life = 3
	
func reload_game():
	await get_tree().create_timer(1.0).timeout
	var player = player_scene.instantiate()
	add_child(player)
	globals.player = player
	globals.player.follow_camera(camera)
	globals.player.player_has_died.connect(reload_game)
	globals.respawn_player()
	get_tree().reload_current_scene()

