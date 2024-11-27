extends Area2D

@onready var collision: CollisionShape2D = $spikes_area/collision
@onready var spikes: Sprite2D = $spikes_area/spikes

func _ready():
	collision.shape.size = spikes.get_rect().size
	
func _on_body_entered(body):
	if body.name == body && body.has_method('take_damage'):
		print('player nos espinhos')
		body.take_damage(Vector2(0, 250))
