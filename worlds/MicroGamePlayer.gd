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

var current_game_id : int

# Called when the node enters the scene tree for the first time.
func _ready():
	loadScenes()
	$TimerGraphic.visible = false
	$EndMessage.visible = false
	
	#testing
	cutscene()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	updateTimer()

func updateTimer():
	$TimerGraphic/Label.text = "%d" % (ceil($GameTimer.time_left))

func loadScenes():
	gameScenes.append(preload("res://games/ShavingGame/ShavingGame.tscn"))
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

	#Set up direction animation
	$DirectionMessage.visible = true
	get_tree().paused = true
	
	#play transition
	$Transition/TransitionAnimPlayer.play("Enter_Game")

	current_game_id = gameID

func play_direction_animation(gameID : int):
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
	$MessageTimer.start()

func loseGame():
	print("Lose game in parent")
	$GameTimer.stop()
	total_losses += 1
	
	play_end_text_animation("LOSE!", Color(1, 0, 0))
	$MessageTimer.start()

func _on_message_timer_timeout():
	$Transition/TransitionAnimPlayer.play("Exit_Game")



func endGame():
	if is_instance_valid(game_inst):
		game_inst.queue_free()
	$TimerGraphic.visible = false
	
	enter_cutscene()

func play_end_text_animation(message: String, color: Color):
	$EndMessage/Label.text = message
	$EndMessage/Label.label_settings.font_color = color
	$EndMessage/MessageAnimPlayer.play("Animation")
	$EndMessage/MessageBuffer.start()

func _on_message_buffer_timeout():
	$EndMessage.visible = true

func _on_message_anim_player_animation_finished(anim_name):
	$EndMessage.visible = false


func _on_game_timer_timeout():
	print("game timer timeout")
	loseGame()

func cutscene():
	$InbetweenTimer.start()

func _on_inbetween_timer_timeout():
	exit_cutscene()

func enter_cutscene():
	$Transition/TransitionAnimPlayer.play("Enter_Cutscene")

func exit_cutscene():
	$Transition/TransitionAnimPlayer.play("Exit_Cutscene")

func _on_transition_anim_player_animation_finished(anim_name):
	if (anim_name == "Enter_Cutscene"):
		cutscene()
	elif (anim_name == "Exit_Cutscene"):
		startGame(randi_range(0, gameScenes.size()-1))
	elif (anim_name == "Enter_Game"):
		play_direction_animation(current_game_id)
	elif (anim_name == "Exit_Game"):
		endGame()









