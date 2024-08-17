extends Base_Game

#Pixels per second
var has_won : bool = false
var has_lost : bool = false
@export var knife_speed : int
@export var sweetspot_size : int
@onready var knife := $Knife_Folloing
@onready var fruit := $Fruit

func _ready():
	#Setup timers
	timers = [5, 4, 3, 2]
	
	knife.speed = knife_speed
	$Fruit/CollisionShape2D.shape.size.x = sweetspot_size

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
		has_won = true
		has_lost = true
		super.onWin()
		print("Win")
