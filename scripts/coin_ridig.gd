extends RigidBody2D


func _on_coins_tree_exited() -> void:
	queue_free()
	pass
