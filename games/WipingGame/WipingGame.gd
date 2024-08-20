extends Base_Game

@export var swipes_to_win : int
var total_swipes : int = 0
@onready var mouse_prop = InputEventMouseMotion
var curr_vel = Vector2(0,0)
var has_won : bool = false
@onready var cursorrag = load("res://assets/sprites/rag.png")
var prev_mouse_pos: Vector2
@onready var sprites : Array[CompressedTexture2D]
# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	timers = [5, 4, 3, 2]
	setupSprites()
	prev_mouse_pos = get_global_mouse_position()
	directionMessage = "WIPE!!"
	$MouseDetection.start()

func setupSprites():
	if GlobalVars.game_stage == 0:
		sprites.append(load("res://assets/sprites/plate.png"))
		sprites.append(load("res://assets/sprites/dirt1.png"))
		sprites.append(load("res://assets/sprites/dirt2.png"))
		sprites.append(load("res://assets/sprites/dirt3.png"))
		sprites.append(load("res://assets/sprites/dirt4.png"))
		sprites.append(load("res://assets/sprites/dirt5.png"))
	if GlobalVars.game_stage == 1:
		sprites.append(load("res://assets/sprites/road.png"))
		sprites.append(load("res://assets/sprites/roadlines1.png"))
		sprites.append(load("res://assets/sprites/roadlines2.png"))
		sprites.append(load("res://assets/sprites/roadlines3.png"))
		sprites.append(load("res://assets/sprites/roadlines4.png"))
		sprites.append(load("res://assets/sprites/roadlines5.png"))
		$Plate.position.y -= 4
		$Plate.position.x += 3
	if GlobalVars.game_stage == 2:
		sprites.append(load("res://assets/sprites/road.png"))
		sprites.append(load("res://assets/sprites/wholecity1.png"))
		sprites.append(load("res://assets/sprites/wholecity2.png"))
		sprites.append(load("res://assets/sprites/wholecity3.png"))
		sprites.append(load("res://assets/sprites/wholecity4.png"))
		sprites.append(load("res://assets/sprites/wholecity5.png"))
	$Plate.texture = sprites[0]

func getPlateDirtiness():
	if total_swipes == 0:
		$Dirtiness.texture = sprites[1]
	elif total_swipes == 1:
		$Dirtiness.texture = sprites[2]
	elif total_swipes == 2:
		$Dirtiness.texture = sprites[3]
	elif total_swipes == 3:
		$Dirtiness.texture = sprites[4]
	elif total_swipes == 4:
		$Dirtiness.texture = sprites[5]
	elif total_swipes == 5:
		$Dirtiness.texture = null

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	getPlateDirtiness()
	if total_swipes >= swipes_to_win and not has_won:
		print("Won in game")
		super.onWin()
		has_won = true
	if get_global_mouse_position() != prev_mouse_pos:
		if get_global_mouse_position().x > prev_mouse_pos.x:
			$Cursor.rotation_degrees = lerpf($Cursor.rotation_degrees, 45, .1)
		else:
			$Cursor.rotation_degrees = lerpf($Cursor.rotation_degrees, -45, .1)
	else:
		$Cursor.rotation_degrees = lerpf($Cursor.rotation_degrees, 0, .1)
	prev_mouse_pos = get_global_mouse_position()
func _input(event):
	if event is InputEventMouseMotion:
		curr_vel = event.velocity

func _on_mouse_detection_timeout():
	if curr_vel.x > 5 or curr_vel.y > 5 and not has_won:
		total_swipes += 1
		$rubbingSFX.play()
