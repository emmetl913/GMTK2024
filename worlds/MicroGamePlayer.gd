extends Node2D

@export var total_losses : int
@export var total_wins : int
@export var first_game_index : int
var game_inst
@export var gameScenes : Array[Resource] = []
@export var audio : Array[AudioStreamWAV] = []

#Starts at 1, increases after each round of micro games.
#Used to tell game scenes which sprites to draw and what difficulty to select
@export var game_phase : int

# Called when the node enters the scene tree for the first time.
func _ready():
	loadScenes()
	$TimerGraphic.visible = false
	$EndMessage.visible = false
	
	#testing

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	updateTimer()

func updateTimer():
	$TimerGraphic/Label.text = "%d" % (ceil($GameTimer.time_left))

func loadScenes():
	gameScenes.append(preload("res://games/ChoppingGame/ChoppingGame.tscn"))
	audio.append(preload("res://assets/sfx/chop.wav"))
	gameScenes.append(preload("res://games/PickingGame/PickingGame.tscn"))
	audio.append(preload("res://assets/sfx/pick.wav"))
	gameScenes.append(preload("res://games/ChurningGame/ChurningGame.tscn"))
	audio.append(preload("res://assets/sfx/churn.wav"))
	gameScenes.append(preload("res://games/CrackingGame/CrackingGame.tscn"))
	audio.append(preload("res://assets/sfx/crack.wav"))
	gameScenes.append(preload("res://games/IcingGame/IcingGame.tscn"))
	audio.append(preload("res://assets/sfx/ice.wav"))
	gameScenes.append(preload("res://games/WipingGame/WipingGame.tscn"))
	audio.append(preload("res://assets/sfx/wipe.wav"))
	gameScenes.append(preload("res://games/CleaningGame/CleaningGame.tscn"))
	audio.append(preload("res://assets/sfx/clean.wav"))
	gameScenes.append(preload("res://games/PullingGame/PullingGame.tscn"))
	audio.append(preload("res://assets/sfx/pull.wav"))

func startGame(gameID: int):
	game_inst = gameScenes[gameID].instantiate()
	game_inst.set_parent(self)
	add_child(game_inst, true)
	
	$TimerGraphic.visible = true
	$GameTimer.wait_time = game_inst.getTimer(game_phase)
	$DirectionMessage/Label.text = game_inst.directionMessage
	
	play_direction_animation(gameID)

func play_direction_animation(gameID : int):
	$DirectionMessage.visible = true
	
	#pause game
	get_tree().paused = true
	
	#play sound cue
	$AudioStreamPlayer.stream = audio[gameID]
	$AudioStreamPlayer.play()
	
	#play animation
	$DirectionMessage/DirectionAnimPlayer.play("Animation")

func _on_direction_anim_player_animation_finished(anim_name):
	get_tree().paused = false
	$DirectionMessage.visible = false
	
	$GameTimer.start()

func winGame():
	print("Win game in parent")
	$GameTimer.stop()
	total_wins += 1
	
	play_end_text_animation("WIN!", Color(0, 0.64, 0.13))

func loseGame():
	print("Lose game in parent")
	$GameTimer.stop()
	total_losses += 1
	
	play_end_text_animation("LOSE!", Color(1, 0, 0))

func endGame():
	if is_instance_valid(game_inst):
		game_inst.queue_free()
	$InbetweenTimer.start()
	$TimerGraphic.visible = false

func play_end_text_animation(message: String, color: Color):
	$EndMessage/Label.text = message
	$EndMessage/Label.label_settings.font_color = color
	$EndMessage/MessageAnimPlayer.play("Animation")
	$EndMessage/MessageBuffer.start()

func _on_message_buffer_timeout():
	$EndMessage.visible = true

func _on_message_anim_player_animation_finished(anim_name):
	$EndMessage.visible = false
	endGame()

func _on_game_timer_timeout():
	print("game timer timeout")
	loseGame()

func _on_inbetween_timer_timeout():
	startGame(randi_range(0, gameScenes.size()-1))








