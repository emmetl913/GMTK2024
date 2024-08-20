extends Node2D

@onready var game_ind : int = -1
@export var total_losses : int
@export var total_wins : int
@export var first_game_index : int
var game_inst
@export var gameScenes : Array[Resource] = []
@export var audio : Array[AudioStreamWAV] = []

@export var cutsceneScene : Resource
var cutsceneInst

@onready var cakeLayerScene = preload("res://worlds/cake_piece.tscn")
#var cakeLayerScene: Resource

#Starts at 1, increases after each round of micro games.
#Used to tell game scenes which sprites to draw and what difficulty to select
@export var game_phase : int

#Saved persistently in MGM
@export var cake_layers : Array[int]
#Used to tell cutscene which type of cake layer to add
#bool true=win, false=loss
var recentGameWon

#@onready var music = preload("res://assets/music/funny2.wav")

#Fields for Lives
var lives : int
@export var livesDisplaySprites : Array[Texture2D]

var current_game_id : int

@onready var cinematicScene = preload("res://worlds/cinematic.tscn")
var cinematicInst

# Called when the node enters the scene tree for the first time.
func _ready():
	GlobalVars.game_stage = 0
	loadScenes()
	$TimerGraphic.visible = false
	$EndMessage.visible = false
	
	lives = 3
	
	showCinematic()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	updateTimer()

func updateTimer():
	$TimerGraphic/Label.text = "%d" % (ceil($GameTimer.time_left))

func loadScenes():
	gameScenes.append(preload("res://games/ShavingGame/ShavingGame.tscn"))
	audio.append(preload("res://assets/sfx/shave.wav"))
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
	gameScenes.append(preload("res://games/ShovelingGame/ShovelingGame.tscn"))
	audio.append(preload("res://assets/sfx/shovel.wav"))
	gameScenes.append(preload("res://games/SeasoningGame/SeasoningGame.tscn"))
	audio.append(preload("res://assets/sfx/season.wav"))
	#If we add more games add them below pls
	
	#Cutscene Scenes
	cutsceneScene = preload("res://worlds/cutscene.tscn")

func startGame(gameID: int):

	game_inst = gameScenes[gameID].instantiate()
	game_inst.set_parent(self)
	add_child(game_inst, true)
	
	#Set cursor back to visible unless game is pick or wipe or ICING
	if gameID != 2 and gameID != 5  and gameID != 6:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
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
	recentGameWon = true
	
	play_end_text_animation("WIN!", Color(0, 0.64, 0.13))
	$MessageTimer.start()

func loseGame():
	print("Lose game in parent")
	$GameTimer.stop()
	total_losses += 1
	lives -= 1
	update_lives()
	recentGameWon = false
	
	play_end_text_animation("LOSE!", Color(1, 0, 0))
	$MessageTimer.start()

#updates lives display
func update_lives():
	$LivesDisplay/Sprite2D.texture = livesDisplaySprites[lives]

func _on_message_timer_timeout():
	$Transition/TransitionAnimPlayer.play("Exit_Game")

func endGame():
	if is_instance_valid(game_inst):
		game_inst.queue_free()
	$TimerGraphic.visible = false
	
	#if lives = 0, lose game
	if (lives == 0):
		lose()
	
	#if total rounds completed = 33, win game
	if (total_wins + total_losses >= 33):
		win()
	
	#if rounds completed is a multiple of 11, show cinematic
	if ((total_wins + total_losses) % 11 == 0):
		showCinematic()
	else:
		enter_cutscene()

#When player has officially lost the game, takes them to the lose screen
func lose():
	#Changes scene to lose screen
	get_tree().change_scene_to_file("res://menus/lose_screen.tscn")

func win():
	#Changes scene to win screen
	if !GlobalVars.is_endless:
		SaveData.beat_story_mode = true
		SaveData.save(0)
	get_tree().change_scene_to_file("res://worlds/RobotBakesTheEarth.tscn")

func showCinematic():
	$LivesDisplay.visible = false
	$Transition.visible = false
	
	$Music.stop()
	
	#load cinematic
	cinematicInst = cinematicScene.instantiate()
	cinematicInst.setParent(self)
	cinematicInst.get_node("Objective").texture_filter = 1
	if GlobalVars.game_stage == 0:
		cinematicInst.setObjectiveSprite(preload("res://assets/sprites/kitchenstuff.png"))
	add_child(cinematicInst, true)
	
	cinematicInst.playAnimation()

func endCinematic():
	$LivesDisplay.visible = true
	$Transition.visible = true
	
	if is_instance_valid(cinematicInst):
		cinematicInst.queue_free()
	
	$Music.play()
	
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
	pass#$InbetweenTimer.start()

func _on_inbetween_timer_timeout():
	exit_cutscene()

func enter_cutscene():
	cutsceneInst = cutsceneScene.instantiate()
	cutsceneInst.setMicroGamePlayer(self)
	add_child(cutsceneInst, true)
	
	$Transition/TransitionAnimPlayer.play("Enter_Cutscene")

func exit_cutscene():
	$Transition/TransitionAnimPlayer.play("Exit_Cutscene")

func _on_transition_anim_player_animation_finished(anim_name):
	if (anim_name == "Enter_Cutscene"):
		cutscene()
	elif (anim_name == "Exit_Cutscene"):
		#remove cutscene inst
		if is_instance_valid(cutsceneInst):
			cutsceneInst.queue_free()
		
		#Start new game
		if GlobalVars.is_endless:
			startGame(randi_range(0, gameScenes.size()-1))
		elif not GlobalVars.is_endless:
			if game_ind < gameScenes.size()-1:
				game_ind += 1
			elif game_ind == gameScenes.size()-1:
				print("Game stage: ", GlobalVars.game_stage)
				GlobalVars.game_stage += 1
				game_ind = 0
			startGame(game_ind)
	elif (anim_name == "Enter_Game"):
		play_direction_animation(current_game_id)
	elif (anim_name == "Exit_Game"):
		endGame()


