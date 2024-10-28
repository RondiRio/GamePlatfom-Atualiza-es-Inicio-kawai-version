extends AnimatableBody2D

@onready var animation := $animation as AnimationPlayer
@onready var respawn_timer := $respawn_timer as Timer
@onready var respawn_position := global_position

@export var reset_timer := 1.0

var velocity := Vector2.ZERO
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var is_triggered := false

func _ready() -> void:
	set_physics_process(false)  # Desativa a física inicialmente
	respawn_timer.wait_time = reset_timer  # Configura o timer para resetar a plataforma


func _physics_process(delta: float) -> void:
	# Aplica gravidade à plataforma e ajusta a posição
	velocity.y += (gravity * delta)/2
	position += velocity * delta

func has_collided_with(collision: KinematicCollision2D, collider: CharacterBody2D):
	if !is_triggered:
		is_triggered = true
		animation.play("shake")  # Inicia a animação de queda
		velocity = Vector2.ZERO
		#set_physics_process(true)  # Ativa a física para iniciar a queda

func _on_animation_animation_finished(anim_name: StringName) -> void:
	set_physics_process(true)
	respawn_timer.start(reset_timer)
	

func _on_respawn_timer_timeout() -> void:
	set_physics_process(false)
	global_position = respawn_position
	if is_triggered:
		var spawn_tween = create_tween().set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_IN_OUT)
		spawn_tween.tween_property($texture, "scale", Vector2(1, 1), 0.2).from(Vector2(0,0))
	is_triggered = false
