extends Base_Game

var has_lost : bool = false
var has_won : bool = false
var cook_time : int
@export var grab_time : float

@onready var cooktime = $CookTime
@onready var grabwindow = $GrabWindow

# Called when the node enters the scene tree for the first time.
func _ready():
	$Wait.text = "Wait"
	timers = [7, 6, 5, 4, 3, 2]
	cook_time = randi_range(2, 6)
	cooktime.wait_time = cook_time
	grabwindow.wait_time = grab_time
	cooktime.start()

func _input(event):
	if event.is_action_pressed("LMB") and grabwindow.time_left > 0:
		super.onWin()
		has_won = true


func _on_cook_time_timeout():
	$Cake.visible = true
	$Wait.text = "Pull!!!!"
	grabwindow.start()


func _on_grab_window_timeout():
	if not has_won and not has_lost:
		super.onLose()
		has_lost = true
