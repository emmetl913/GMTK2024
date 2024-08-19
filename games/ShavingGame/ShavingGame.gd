extends Base_Game

@export var max_right: float
@export var max_left: float
var dir: float = 1.0
@export var speed: float
@export var shaver_speed: float
@export var drop_speed:float 
@onready var sprites : Array[CompressedTexture2D]

var move_shaver = false
var is_shaver_down = false

var shaver_dir: float = 1.0

var shave_count: int = 0
var num_to_shave =2
var can_shave = true
var has_result = false

var drop_left = false
var drop_right = false
func _ready():
	#GameSetup
	timers = [5, 4, 3, 2]
	setupSprites()
	directionMessage = "SHAVE!!"
	if randi_range(1,2) == 1:
		num_to_shave = 2
		#addExtraShaveable()

func setupSprites():
	print("Game Stage: ", GlobalVars.game_stage)
	if GlobalVars.game_stage == 0:
		sprites.append(load("res://assets/sprites/coconutNoSides.png"))
		sprites.append(load("res://assets/sprites/CoconutSide.png"))
		sprites.append(load("res://assets/sprites/CoconutSide.png"))
		sprites.append(load("res://assets/sprites/red_arrow.png"))
		sprites.append(load("res://assets/sprites/grater.png"))
	elif GlobalVars.game_stage == 1:
		sprites.append(load("res://assets/sprites/treenosides.png"))
		sprites.append(load("res://assets/sprites/treeside.png"))
		sprites.append(load("res://assets/sprites/treeside.png"))
		sprites.append(load("res://assets/sprites/red_arrow.png"))
		sprites.append(load("res://assets/sprites/chainsaw.png"))
	elif GlobalVars.game_stage == 2:
		$ColorRect.color = Color(0, 0, 0)
		sprites.append(load("res://assets/sprites/earthnosides.png"))
		sprites.append(load("res://assets/sprites/earthsideleft.png"))
		sprites.append(load("res://assets/sprites/earthsideright.png"))
		sprites.append(load("res://assets/sprites/red_arrow.png"))
		sprites.append(load("res://assets/sprites/knife.png"))
		$Shaveables/Sprite2D3.flip_h = true
	$Shaveables/Sprite2D.texture = sprites[0]
	$Shaveables/Sprite2D/Sprite2D.texture = sprites[3]
	$Shaveables/Sprite2D/Sprite2D2.texture = sprites[3]
	$Shaveables/Sprite2D2.texture = sprites[1]
	$Shaveables/Sprite2D3.texture = sprites[2]
	$Shaver.texture = sprites[4]


func addExtraShaveable():
	$Shaveables/Sprite2D4/Area2D/CollisionShape2D.disabled = false
	$Shaveables/Sprite2D4.visible = true
	if randi_range(1,2) == 1:
		#Add to the left position
		$Shaveables/Sprite2D4.position.x = -115
	else:
		#Right position
		$Shaveables/Sprite2D4.position.x = 115
func _process(delta):
	if drop_left:
		$Shaveables/Sprite2D2.position.y += drop_speed * delta
	if drop_right:
		$Shaveables/Sprite2D3.position.y += drop_speed * delta
	if $Shaveables.position.x > max_right:
		dir = -1.0
	elif $Shaveables.position.x < max_left:
		dir = 1.0
	#lerp
	$Shaveables.position += Vector2(1.0 * dir * speed * delta, 0)
	
	if move_shaver and ($Shaver.position.y <= 140 and $Shaver.position.y >= 20):
		$Shaver.position.y += 1.0 * shaver_dir * shaver_speed * delta
	else:
		move_shaver = false
func _input(event):
	if event.is_action_pressed("LMB"):
		if !move_shaver:
			slideShaver()

func slideShaver():
	move_shaver = true
	is_shaver_down = !is_shaver_down
	#lerp y 
	if is_shaver_down:
		shaver_dir = 1.0
		$Shaver.position.y = 20
	else:
		shaver_dir = -1.0
		$Shaver.position.y = 140


func _on_shave_area_area_entered(area):
	if area.is_in_group("ShaveLose") and !has_result:
		area.get_parent().self_modulate = Color.DARK_RED
		super.onLose()
		has_result = true
	elif area.is_in_group("CleanShave") and !has_result and can_shave:
		shave_count += 1
		can_shave = false
		$ShaveCD.start(.3)
		if area.is_in_group("Left"):
			drop_left = true
			$ShaveSFX.play()
		else:
			drop_right = true
			$ShaveSFX.play()
		if shave_count == num_to_shave:
			super.onWin()
			has_result = true


func _on_shave_cd_timeout():
	can_shave = true
