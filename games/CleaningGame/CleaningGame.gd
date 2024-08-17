extends Base_Game

var count

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$CharacterBody2D.position = get_global_mouse_position()


func _on_area_2d_area_entered(area):
	for i in get_overlapping_areas():
		if area.is_in_group("trash"):
			count += 1
