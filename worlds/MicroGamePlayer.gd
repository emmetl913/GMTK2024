extends Node2D

@export var total_losses : int
@export var total_wins : int
@export var first_game_index : int
var game_inst
@export var gameScenes : Array[Resource] = []

#Starts at 1, increases after each round of micro games.
#Used to tell game scenes which sprites to draw and what difficulty to select
@export var game_phase : int

# Called when the node enters the scene tree for the first time.
func _ready():
	loadScenes()
	$TimerGraphic/Label.visible = false
	
	#testing

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	updateTimer()

func updateTimer():
	$TimerGraphic/Label.text = "%d" % ($GameTimer.time_left + 1)

func loadScenes():
	gameScenes.append(preload("res://games/ChoppingGame/ChoppingGame.tscn"))
	gameScenes.append(preload("res://games/PickingGame/PickingGame.tscn"))
	gameScenes.append(preload("res://games/ChurningGame/ChurningGame.tscn"))
	gameScenes.append(preload("res://games/CrackingGame/CrackingGame.tscn"))
	gameScenes.append(preload("res://games/IcingGame/IcingGame.tscn"))

func startGame(gameID: int):
	game_inst = gameScenes[gameID].instantiate()
	game_inst.set_parent(self)
	add_child(game_inst, true)
	
	#Start game timer
	$TimerGraphic/Label.visible = true
	$GameTimer.wait_time = game_inst.getTimer(game_phase)
	$GameTimer.start()

func winGame():
	print("Win game in parent")
	$GameTimer.stop()
	if is_instance_valid(game_inst):
		game_inst.queue_free()
		total_wins += 1
	$InbetweenTimer.start()
	
	$TimerGraphic/Label.visible = false

func loseGame():
	print("Lose game in parent")
	$GameTimer.stop()
	if is_instance_valid(game_inst):
		game_inst.queue_free()
		total_losses += 1
	$InbetweenTimer.start()
	
	$TimerGraphic/Label.visible = false


func _on_game_timer_timeout():
	print("game timer timeout")
	loseGame()

func _on_inbetween_timer_timeout():
	startGame(randi_range(0, gameScenes.size()-1))
