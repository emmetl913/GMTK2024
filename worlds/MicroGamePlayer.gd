extends Node2D

@export var first_game_index : int

@export var gameScenes : Array[Resource] = []

# Called when the node enters the scene tree for the first time.
func _ready():
	loadScenes()
	
	#testing
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func loadScenes():
	gameScenes.append(preload("res://games/ChoppingGame/ChoppingGame.tscn"))
	gameScenes.append(preload("res://games/PickingGame/PickingGame.tscn"))

func startGame(gameID: int):
	var game_inst = gameScenes[gameID].instance()
	
	add_child(game_inst, true)

func winGame():
	pass

func loseGame():
	pass
