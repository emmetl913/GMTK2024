extends Base_Game

var bushItems: Array[Node2D]
# Called when the node enters the scene tree for the first time.
func _ready():
	#Setup timers
	timers = [5, 4, 3, 2]
	for i in get_children():
		if i.is_in_group("BushItem"):
			bushItems.append(i)

func _input(event):
	if event.is_action_pressed("LMB"):
		for i in bushItems:
			if i.in_range:
				i.self_modulate = Color.GREEN

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
