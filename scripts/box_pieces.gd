extends RigidBody2D

func _on_notfier_screen_exited():
	queue_free()
