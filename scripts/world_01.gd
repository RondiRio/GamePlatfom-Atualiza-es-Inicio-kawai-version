extends Node2D

@onready var player := $player as CharacterBody2D
#@onready var player_scene = preload("res://Actors/player.tscn")
@onready var camera := $camera as Camera2D

func _ready() -> void:
	player.follow_camera(camera)
	player.player_has_die.connect(reload_game)
	globals.coins = -29
	globals.score = 0
	globals.player_life = 3
	
func _process(delta: float) -> void:
	pass

func reload_game():
	await  get_tree().create_timer(1.0).timeout
	get_tree().reload_current_scene()
