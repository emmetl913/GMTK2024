extends Node2D

@export var total_losses : int
@export var total_wins : int
@export var first_game_index : int
var game_inst
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
	gameScenes.append(preload("res://games/ChurningGame/ChurningGame.tscn"))
	gameScenes.append(preload("res://games/CrackingGame/CrackingGame.tscn"))

func startGame(gameID: int):
	game_inst = gameScenes[gameID].instantiate()
	game_inst.set_parent(self)
	add_child(game_inst, true)

func winGame():
	print("Win game in parent")
	game_inst.queue_free()
	total_wins += 1
	$InbetweenTimer.start()

func loseGame():
	print("Lose game in parent")
	game_inst.queue_free()
	total_losses += 1
	$InbetweenTimer.start()


func _on_game_timer_timeout():
	pass

func _on_inbetween_timer_timeout():
	startGame(randi_range(0, gameScenes.size()-1))
