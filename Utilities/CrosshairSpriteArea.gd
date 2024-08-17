extends Node2D

func _process(delta):
	position = Vector2(get_global_mouse_position().x + 3, get_global_mouse_position().y + 4)
