extends Node2D

var in_range = false
var is_good = true
var success = false

func _ready():
	if randi_range(1,3) == 1:
		is_good = false
		
	if !is_good:
		setBad()
func _on_area_2d_area_entered(area):
	if area.is_in_group("Cursor"):
		in_range = true
func setBad():
	#self_modulate = Color.DARK_RED
	is_good = false
func setGood():
	#self_modulate = Color.WHITE
	is_good = true
func _on_area_2d_area_exited(area):
	if area.is_in_group("Cursor"):
		in_range = false

func isInRange():
	return in_range

func successState():
	self_modulate = Color.GREEN
	success = true

func randomNewPosition():
	var p = get_parent()
	position = Vector2(p.centerScreenOffset.x + randf_range(p.spawnRange.x,p.spawnRange.y), p.centerScreenOffset.y +  + randf_range(p.spawnRange.x,p.spawnRange.y)/2)

func _on_spawn_collision_detection_area_entered(area):
	if area.is_in_group("SpawnCollider"):
		randomNewPosition()
