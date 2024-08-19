extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	$FadeIn.visible = true
	$GameOverText.visible = false
	$MainMenuButton.visible = false
	$Robot.visible = false
	
	$AnimationPlayer.play("FadeIn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_animation_player_animation_finished(anim_name):
	if (anim_name == "FadeIn"):
		$AnimationPlayer.play("ShowRobot")
		$Robot.visible = true
		$FadeIn.visible = false
	elif (anim_name == "ShowRobot"):
		$AnimationPlayer.play("ShowGameOver")
		$GameOverText.visible = true
	elif (anim_name == "ShowGameOver"):
		$AnimationPlayer.play("ShowMainMenuButton")
		$MainMenuButton.visible = true


func _on_main_menu_button_pressed():
	get_tree().change_scene_to_file("res://menus/MainMenu.tscn")
