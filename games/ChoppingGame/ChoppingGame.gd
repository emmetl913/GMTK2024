extends Base_Game

#Pixels per second
var has_won : bool = false
var has_lost : bool = false
@export var knife_speed : int
@export var sweetspot_size : int
@onready var knife := $Knife_Folloing
@onready var fruit := $Fruit
@onready var sprites : Array[CompressedTexture2D]

func _ready():
	#Setup timers
	timers = [5, 4, 3, 2]
	directionMessage = "CHOP!!"
	setupSprites()
	knife.speed = knife_speed
	$Fruit/CollisionShape2D.shape.size.x = sweetspot_size

func setupSprites():
	if GlobalVars.game_stage == 0:
		sprites.append(load("res://assets/sprites/knife.png"))
		sprites.append(load("res://assets/sprites/strawberry.png"))
		sprites.append(load("res://assets/sprites/strawberryhalf.png"))
		knife_speed = 500
	elif GlobalVars.game_stage == 1:
		sprites.append(load("res://assets/sprites/rustyknife.png"))
		sprites.append(load("res://assets/sprites/car.png"))
		sprites.append(load("res://assets/sprites/carhalf.png"))
		knife_speed = 575
	elif GlobalVars.game_stage == 2:
		sprites.append(load("res://assets/sprites/rustyknife.png"))
		sprites.append(load("res://assets/sprites/mountain.png"))
		sprites.append(load("res://assets/sprites/mountainhalf.png"))
		knife_speed = 625
	$Knife_Folloing/Path2D/PathFollow2D/Knife/Knife.texture = sprites[0]
	$Fruit/Sprite2D.texture = sprites[1]
	$Fruit/Sprite2D2.texture = sprites[2]

func _input(event):
	if event.is_action_pressed("LMB"):
		knife.has_cut = true

func _process(delta):
	if not has_lost and $Knife_Folloing/Path2D/PathFollow2D/Knife.position.y > 100:
		has_lost = true
		super.onLose()
		print("Lose")

func set_parent(par : Node2D):
	super.set_parent(par)

func _on_fruit_body_entered(body):
	if not has_won:
		$SliceSFX.play()
		has_won = true
		has_lost = true
		super.onWin()
		print("Win")
