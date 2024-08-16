extends Node2D

@onready var path_follow := $Path2D/PathFollow2D
@onready var has_cut : bool = false
var speed : int
var dir : bool = true
var is_tween : bool = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not has_cut:
		path_follow.progress += speed*delta
	elif has_cut and not is_tween:
		var tween = get_tree().create_tween()
		tween.tween_property($Path2D/PathFollow2D/Knife, "position", Vector2($Path2D/PathFollow2D/Knife.position.x, 120), 1)
		is_tween = true
