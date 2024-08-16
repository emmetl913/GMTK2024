extends Base_Game

#Pixels per second
var has_won : bool = false
@export var knife_speed : int
@export var sweetspot_size : int
@onready var knife := $Knife_Folloing
@onready var fruit := $Fruit

func _ready():
	knife.speed = knife_speed
	$Fruit/CollisionShape2D.shape.size.x = sweetspot_size

func _input(event):
	if event.is_action_pressed("LMB"):
		knife.has_cut = true

func _process(delta):
	if not has_won and $Knife_Folloing/Path2D/PathFollow2D/Knife.position.y > 110:
		has_won = false
		super.onLose()
		print("Lose")

func set_parent(par : Node2D):
	super.set_parent(par)

func _on_fruit_body_entered(body):
	has_won = true
	super.onWin()
	print("Win")
