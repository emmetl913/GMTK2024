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
	directionMessage = "PULL!!"
	timers = [7, 6, 5, 4, 3, 2]
	setupSprites()
	cook_time = randf_range(1, 6)
	cooktime.wait_time = cook_time
	grabwindow.wait_time = grab_time
	cooktime.start()

func setupSprites():
	if GlobalVars.game_stage == 0:
		$Cake.texture = load("res://assets/sprites/lilcake.png")
		grab_time = 0.5
	elif GlobalVars.game_stage == 1:
		$Cake.texture = load("res://assets/sprites/coal.png")
		grab_time = 0.35
	elif GlobalVars.game_stage == 2:
		$Cake.texture = load("res://assets/sprites/island3.png")
		grab_time = 0.26

func _input(event):
	if event.is_action_pressed("LMB") and grabwindow.time_left > 0 and not has_won and not has_lost:
		$AnimationPlayer.play("TakeCake")
		super.onWin()
		has_won = true


func _on_cook_time_timeout():
	$TickingSFX.stop()
	$Robit.texture = load("res://assets/sprites/robitopen.png")
	$Cake.visible = true
	if not has_won:
		$OvenTimerSFX.play()
	$Wait.text = "Pull!!!!"
	grabwindow.start()


func _on_grab_window_timeout():
	if not has_won and not has_lost:
		super.onLose()
		has_lost = true
