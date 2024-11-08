extends Area2D

var is_active = false
@onready var anim: AnimatedSprite2D = $anim

func _on_body_entered(body):
	if body.name != "player" or is_active:
		return
	activate_chekpoint()

func activate_chekpoint():
	globals.current_chekpoint = position
	anim.play("raising")
	is_active = true
	


func _on_anim_animation_finished() -> void:
	if anim.animation == "raising":
		anim.play("checked")
