extends Base_Game

var starting_button : bool
@export var total_churns : int
@export var win_churns : int
var churn_top : int
var churn_bottom : int
var has_won : bool = false
var has_lost : bool = false
@onready var sprites : Array[CompressedTexture2D]
# Called when the node enters the scene tree for the first time.
func _ready():
	updateMeter()
	
	#Setup timers
	timers = [5, 4, 3, 2]
	
	directionMessage = "CHURN!!"
	setupSprites()
	setup()

func setupSprites():
	if GlobalVars.game_stage == 0:
		sprites.append(load("res://assets/sprites/churn_basin.png"))
		sprites.append(load("res://assets/sprites/churn_stick.png"))
		sprites.append(load("res://assets/sprites/car.png"))
		sprites.append(load("res://assets/sprites/carcrushed.png"))
		$Subject.visible = false
		churn_top = 64
		churn_bottom = 78
	elif GlobalVars.game_stage == 1:
		sprites.append(load("res://assets/sprites/carpressbottom.png"))
		sprites.append(load("res://assets/sprites/carpresstop.png"))
		sprites.append(load("res://assets/sprites/car.png"))
		sprites.append(load("res://assets/sprites/carcrushed.png"))
		$Subject.visible = true
		churn_top = 58
		churn_bottom = 92
		$Churn.z_index += 2
	$Basin.texture = sprites[0]
	$Churn.texture = sprites[1]
	$Subject.texture = sprites[2]

func _input(event):
	updateMeter()
	if event.is_action_pressed("W") and $W.visible and not has_won:
		$Churn.position.y = churn_top
		$W.visible = not $W.visible
		$S.visible = not $S.visible
		$Subject.texture = sprites[2]
		total_churns += 1
	elif event.is_action_pressed("W") and not $W.visible and not has_won:
		super.onLose()
	if event.is_action_pressed("S") and $S.visible:
		$Churn.position.y = churn_bottom
		$W.visible = not $W.visible
		$S.visible = not $S.visible
		$Subject.texture = sprites[3]
		$ChurnSFX.play()
	elif event.is_action_pressed("S") and not $S.visible and not has_won and not has_lost:
		super.onLose()
		has_lost = true
	if total_churns >= win_churns and not has_won:
		super.onWin()
		has_won = true


func setup():
	if randi_range(0,1):
		starting_button = true
		$Churn.position.y = churn_bottom
	else: 
		false
		$Churn.position.y = churn_top
	$W.visible = starting_button
	$S.visible = not starting_button

func updateMeter():
	var newMeterX = (92 * total_churns) / win_churns
	
	if newMeterX > 92:
		newMeterX = 92
	
	$Meter/meter.size.x = newMeterX

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
