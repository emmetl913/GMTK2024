extends Node2D

@export var cake_layers : Array[CakePiece]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func setUpCake():
	pass

func playNewLayerAnimation():
	$CakePiece.playAnimation()
