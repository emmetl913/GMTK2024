extends Base_Game

var pattern
var has_won : bool = false
var has_lost : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	timers = [5, 4, 3, 2]
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	directionMessage = "ICE!!"
	
	setup()

func setup():
	var pattern_selector = randi_range(1,2)
	if pattern_selector == 1:
		pattern = $SPattern
	elif pattern_selector == 2:
		pattern = $NPattern
	pattern.visible = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$CharacterBody2D.position = get_global_mouse_position()
	if pattern.has_won and $WonTimeout.time_left == 0 and not has_won:
		super.onWin()
		has_won = true
	elif pattern.has_lost and not has_lost and not has_won:
		super.onLose()
		has_lost = true


func _on_won_timeout_timeout():
	super.onWin()
