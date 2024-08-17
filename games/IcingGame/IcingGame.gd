extends Base_Game

var pattern

# Called when the node enters the scene tree for the first time.
func _ready():
	timers = [5, 4, 3, 2]
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
	if pattern.has_won and $WonTimeout.time_left == 0:
		$WonTimeout.start()
	elif pattern.has_failed and $WonTimeout.time_left == 0:
		super.onLose()


func _on_won_timeout_timeout():
	super.onWin()
