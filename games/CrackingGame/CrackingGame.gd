extends Base_Game

var current_stage : Array[bool] = [true, false, false, false]
@export var first_cracks : int
@export var second_cracks : int
@export var third_cracks : int
@export var crack_speed : int
@onready var egg_path = $EggStuff/Path2D/PathFollow2D
@onready var crack_label = $Cracks
var is_cracking : bool = false
var total_cracks : int = 0
var max_cracks : int

# Called when the node enters the scene tree for the first time.
func _ready():
	timers = [5, 4, 3, 2]
	first_cracks = randi_range(1,3)
	second_cracks = randi_range(1,3)
	third_cracks = randi_range(1,3)
	max_cracks = first_cracks + second_cracks + third_cracks
	crack_label.text = "0"
	print("First cracks: ", first_cracks, "   Second cracks: ", second_cracks, "   Third cracks: ", third_cracks)

func _input(event):
	if event.is_action_pressed("LMB"):
		is_cracking = true
		print("Start cracking")
		total_cracks+= 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_cracking:
		print(egg_path.progress_ratio)
		if egg_path.progress_ratio < 1:
			egg_path.progress += crack_speed*delta
		else:
			print("Crack complete")
			egg_path.progress_ratio = 0
			is_cracking = false
	if total_cracks > first_cracks and current_stage[0]:
		crack_label.text = "1"
		current_stage[0] = false
		current_stage[1] = true
	elif total_cracks > second_cracks+first_cracks and current_stage[1]:
		crack_label.text = "2"
		current_stage[1] = false
		current_stage[2] = true
	if total_cracks > max_cracks:
		$EggStuff/Path2D/PathFollow2D/Sprite2D.visible = false
		super.onLose()
	if max_cracks == total_cracks:
		print("Won in game")
		if $Crack_timer.time_left == 0:
			$Crack_timer.start()
		$EggStuff/Path2D/PathFollow2D/Sprite2D.self_modulate = Color(0,1,0)


func _on_crack_timer_timeout():
	print("Timer end")
	super.onWin()
