extends CharacterBody2D
const SPEED = 180.0
const JUMP_FORCE = -250.0
const MAX_JUMPS = 2  # Máximo de saltos (para duplo pulo)
const SPEED_BOOST = 2  # 30% de aumento de velocidade
const BOOST_DURATION = 1.0  # Duração do aumento de velocidade (1s)
const COOLDOWN_TIME = 5.0  # Tempo de recarga (2 minutos)
const DEBUFF_MULTIPLIER = 0.3 
var animation_pulo := false
var jump_count := 0  
var boost_active := false
var cooldown := 0.0
var debuff_active := false
var player_life := 10
var knockback_vector := Vector2.ZERO
var respawn_position := Vector2(100, 100) 
var respawn_time := 3.0  
@onready var animation := $anim as AnimatedSprite2D
@onready var remote_transform := $remote as RemoteTransform2D
func _physics_process(delta: float) -> void:
	if cooldown > 0:
		cooldown -= delta
		if cooldown <= 0:
			debuff_active = false  
	
	# Lida com a gravidade.
	if not is_on_floor():
		velocity += get_gravity() * delta
	else:
		# Reseta o contador de pulos quando está no chão
		jump_count = 0

	# Lida com o pulo.
	var current_jump_force = JUMP_FORCE
	if debuff_active:
		current_jump_force *= DEBUFF_MULTIPLIER  # Aplica debuff ao pulo

	if Input.is_action_just_pressed("ui_accept") and jump_count < MAX_JUMPS:
		velocity.y = current_jump_force
		jump_count += 1
		animation_pulo = true

	# Lida com o movimento.
	var direction := Input.get_axis("ui_left", "ui_right")
	var current_speed = SPEED

	if debuff_active:
		current_speed *= DEBUFF_MULTIPLIER  # Aplica debuff à velocidade
	elif boost_active:
		current_speed *= SPEED_BOOST  # Aplica boost de velocidade

	if direction != 0:
		velocity.x = direction * current_speed
		animation.play("run")
		animation.scale.x = direction
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		animation.play("idle")

	if knockback_vector != Vector2.ZERO:
		velocity = knockback_vector
		
	move_and_slide()

	# Verifica se a habilidade de boost foi ativada
	if Input.is_action_just_pressed("ui_up"):
		if cooldown <= 0:
			await _activate_speed_boost()
		else:
			_apply_debuff()
	
func _activate_speed_boost() -> void:
	boost_active = true
	cooldown = COOLDOWN_TIME  # Inicia o tempo de recarga
	await get_tree().create_timer(BOOST_DURATION).timeout
	boost_active = false

func _apply_debuff() -> void:
	debuff_active = true

func _on_hurtbox_body_entered(body: Node2D) -> void:
	if player_life <= 0:
		queue_free()  # Destrói o player temporariamente
		await _Respaw_temporário()  # Chama a função de respawn
	else:
		if $ray_rigth.is_colliding():
			take_damage(Vector2(-200, -200))
		elif $ray_left.is_colliding():
			take_damage(Vector2(200, -200))

func _Respaw_temporário() -> void:
	await get_tree().create_timer(respawn_time).timeout  # Espera o tempo de respawn
	player_life = 10  # Restaura a vida
	position = respawn_position  # Move o jogador para a posição de respawn
	show()  # Mostra o jogador novamente se estiver oculto
	knockback_vector = Vector2.ZERO  # Reseta o vetor de knockback

func follow_camera(camera: Camera2D) -> void:
	var camera_path = camera.get_path()
	remote_transform.remote_path = camera_path

func take_damage(knockback_force := Vector2.ZERO, duration := 0.25):
	player_life -= 1
	
	if knockback_force != Vector2.ZERO:
		knockback_vector = knockback_force
		
		var knockback_tween := get_tree().create_tween()
		knockback_tween.tween_property(self, "knockback_vector", Vector2.ZERO, duration)
		animation.modulate = Color(1,0,0,1)
		knockback_tween.tween_property(animation, "modulate", Color(1,1,1,1), duration)


func _on_head_collider_body_entered(body: Node2D) -> void:
	if body.has_method("break_sprite"):
		body.hitpoints -= 1
		if body.hitpoints < 0:
			body.break_sprite()
		else:
			body.animation_player.play("hit")
			#body.create_coin()
