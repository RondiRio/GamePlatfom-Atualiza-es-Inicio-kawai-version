extends Node2D

@onready var player := $player as CharacterBody2D
#@onready var player_scene = preload("res://Actors/player.tscn")
@onready var camera := $camera as Camera2D

func _ready() -> void:
	player.follow_camera(camera)
	
func _process(delta: float) -> void:
	pass
