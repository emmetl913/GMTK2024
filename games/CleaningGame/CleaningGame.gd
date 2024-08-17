extends Base_Game

var count : int = 0
var total_offscreen : int = 0
var has_won : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	timers = [5, 4, 3, 2]
	directionMessage = "CLEAN!!"
	$Label.text = "%02d" % count


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$CharacterBody2D.position = get_global_mouse_position()
	if count > 1:
		$Win.stop()

func _input(event):
	pass

func _on_area_2d_body_entered(body):
	count += 1
	$Label.text = "%02d" % count


func _on_area_2d_body_exited(body):
	count -= 1
	$Label.text = "%02d" % count
	if count <= 1 and !has_won:
		super.onWin()



func _on_win_timeout():
	super.onWin()
