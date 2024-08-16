extends Node2D

#Pixels per second
var has_won : bool = false
var parent
@export var knife_speed : int
@export var sweetspot_size : int
@onready var knife := $Knife_Folloing
@onready var fruit := $Fruit

# Called when the node enters the scene tree for the first time.
func _ready():
	knife.speed = knife_speed
	$Fruit/CollisionShape2D.shape.size.x = sweetspot_size

func _input(event):
	if event.is_action_pressed("LMB"):
		knife.has_cut = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not has_won and $Knife_Folloing/Path2D/PathFollow2D/Knife.position.y > 110:
		has_won = false
		print("Lose")


func _on_fruit_body_entered(body):
	has_won = true
	print("Win")
