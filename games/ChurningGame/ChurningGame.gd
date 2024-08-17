extends Base_Game

var starting_button : bool
@export var total_churns : int
@export var win_churns : int
# Called when the node enters the scene tree for the first time.
func _ready():
	setup()

func _input(event):
	if event.is_action_pressed("W") and $W.visible:
		$Churn.position.y = 68
		$W.visible = not $W.visible
		$S.visible = not $S.visible
		total_churns += 1
	elif event.is_action_pressed("W") and not $W.visible:
		super.onLose()
	if event.is_action_pressed("S") and $S.visible:
		$Churn.position.y = 93
		$W.visible = not $W.visible
		$S.visible = not $S.visible
	elif event.is_action_pressed("S") and not $S.visible:
		super.onLose()
	if total_churns >= win_churns:
		super.onWin()


func setup():
	if randi_range(0,1):
		starting_button = true
		$Churn.position.y = 93
	else: 
		false
		$Churn.position.y = 68
	$W.visible = starting_button
	$S.visible = not starting_button

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
