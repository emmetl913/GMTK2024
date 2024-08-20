extends Base_Game

var current_stage : Array[bool] = [true, false, false, false]
@export var first_cracks : int
@export var second_cracks : int
@export var third_cracks : int
@export var crack_speed : int
@onready var egg_path = $EggStuff/Path2D/PathFollow2D
var is_cracking : bool = false
var total_cracks : int = 0
var max_cracks : int
var has_won : bool = false
var has_lost : bool = false
@onready var sprites : Array[CompressedTexture2D]

# Called when the node enters the scene tree for the first time.
func _ready():
	timers = [5, 4, 3, 2]
	directionMessage = "CRACK!!"
	if randi_range(0,100) == 99:
		$ColorRect.texture = load("res://assets/sprites/walta.png")
	setupSprites()
	$EggStuff/Path2D/PathFollow2D/Sprite2D.texture = sprites[0]
	first_cracks = randi_range(1,3)
	second_cracks = randi_range(1,3)
	third_cracks = randi_range(1,3)
	max_cracks = first_cracks + second_cracks + third_cracks
	print("First cracks: ", first_cracks, "   Second cracks: ", second_cracks, "   Third cracks: ", third_cracks)

func setupSprites():
	GlobalVars.game_stage = 2
	if GlobalVars.game_stage == 0:
		sprites.append(load("res://assets/sprites/egg_whole.png"))
		sprites.append(load("res://assets/sprites/egg_crackedalil.png"))
		sprites.append(load("res://assets/sprites/egg_cracked.png"))
	elif GlobalVars.game_stage == 1:
		sprites.append(load("res://assets/sprites/helicopter1.png"))
		sprites.append(load("res://assets/sprites/helicopter2.png"))
		sprites.append(load("res://assets/sprites/helicopter3.png"))
	else:
		sprites.append(load("res://assets/sprites/buildings/building1.png"))
		sprites.append(load("res://assets/sprites/buildings/building1-2.png"))
		sprites.append(load("res://assets/sprites/buildings/building1-3.png"))
func _input(event):
	if event.is_action_pressed("LMB"):
		is_cracking = true
		print("Start cracking")
		total_cracks+= 1
		$CrackSFX.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_cracking:
		#print(egg_path.progress_ratio)
		if egg_path.progress_ratio < 1:
			egg_path.progress += crack_speed*delta
		else:
			print("Crack complete")
			print("Total cracks: ", total_cracks, "   Max Cracks: ", max_cracks)
			egg_path.progress_ratio = 0
			is_cracking = false
	if total_cracks > first_cracks and current_stage[0]:

		current_stage[0] = false
		current_stage[1] = true
		$EggStuff/Path2D/PathFollow2D/Sprite2D.texture = sprites[1]
	elif total_cracks > second_cracks+first_cracks and current_stage[1]:

		current_stage[1] = false
		current_stage[2] = true
		$EggStuff/Path2D/PathFollow2D/Sprite2D.texture = sprites[2]
	if total_cracks > max_cracks and not has_lost:
		has_lost = true
		$EggStuff/Path2D/PathFollow2D/Sprite2D.visible = false
		$Crack_timer.stop()
		super.onLose()
	if max_cracks == total_cracks and not has_won:
		$Crack_timer.start()
		$EggStuff/Path2D/PathFollow2D/Sprite2D.self_modulate = Color(0,1,0)
		has_won = true


func _on_crack_timer_timeout():
	print("Timer end")
	super.onWin()
