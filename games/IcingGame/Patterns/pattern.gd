extends Sprite2D

var first_enter : bool = true
var has_failed : bool = false
var has_won : bool = false
var completed : bool = false
@export var gates : int
@onready var gates_completed : int = 0
@onready var gates_passed : Array[bool] = [false, false, false, false, false, false, false, false, false]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not first_enter and  gates_completed == gates and not has_won:
		print("Won in game")
		has_won = true


func _on_area_2d_body_entered(body):
	$LeaveTimer.stop()
	if first_enter:
		first_enter = false
#func _on_area_2d_area_entered(area):
	#if first_enter and area.is_in_group("cursor"):
		#first_enter = false

func _on_area_2d_body_exited(body):
	if not first_enter and not completed:
		$LeaveTimer.start()
	elif not first_enter and  gates_completed == gates:
		print("Won in game")
#func _on_area_2d_area_exited(area):
	#if not first_enter and not completed and area.is_in_group("cursor"):
		#print("Lost in game")
		#has_failed = true
	#elif not first_enter and  gates_completed == gates and area.is_in_group("cursor"):
		#print("Won in game")

func _on_first_body_entered(body):
	if not gates_passed[0]:
		gates_completed += 1
		$ProgressDetectors/First/Sprite2D.visible = true
		gates_passed[0] = true


func _on_second_body_entered(body):
	if not gates_passed[1]:
		gates_completed += 1
		$ProgressDetectors/Second/Sprite2D.visible = true
		gates_passed[1] = true


func _on_third_body_entered(body):
	if not gates_passed[2]:
		gates_completed += 1
		$ProgressDetectors/Third/Sprite2D.visible = true
		gates_passed[2] = true


func _on_fourth_body_entered(body):
	if not gates_passed[3]:
		gates_completed += 1
		$ProgressDetectors/Fourth/Sprite2D.visible = true
		gates_passed[3] = true


func _on_fifth_body_entered(body):
	if not gates_passed[4]:
		gates_completed += 1
		$ProgressDetectors/Fifth/Sprite2D.visible = true
		gates_passed[4] = true


func _on_sixth_body_entered(body):
	if not gates_passed[5]: 
		gates_completed += 1
		$ProgressDetectors/Sixth/Sprite2D.visible = true
		gates_passed[5] = true


func _on_seventh_body_entered(body):
	if not gates_passed[6]: 
		gates_completed += 1
		$ProgressDetectors/Seventh/Sprite2D.visible = true
		gates_passed[6] = true


func _on_eighth_body_entered(body):
	if not gates_passed[7]: 
		gates_completed += 1
		$ProgressDetectors/Eighth/Sprite2D.visible = true
		gates_passed[7]  = true


func _on_ninth_body_entered(body):
	if not gates_passed[8]: 
		gates_completed += 1
		$ProgressDetectors/Ninth/Sprite2D.visible = true
		gates_passed[8] = true








func _on_leave_timer_timeout():
	print("Lose Game")
