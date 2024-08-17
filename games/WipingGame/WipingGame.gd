extends Base_Game

@export var swipes_to_win : int
var total_swipes : int = 0
@onready var mouse_prop = InputEventMouseMotion
var curr_vel = Vector2(0,0)
var has_won : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	timers = [5, 4, 3, 2]
	$MouseDetection.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if total_swipes >= swipes_to_win and not has_won:
		print("Won in game")
		super.onWin()

func _input(event):
	if event is InputEventMouseMotion:
		curr_vel = event.velocity

func _on_mouse_detection_timeout():
	if curr_vel.x > 5 or curr_vel.y > 5:
		total_swipes += 1
