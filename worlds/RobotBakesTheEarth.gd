extends Node2D

func _ready():
	$YouWinText.visible = false
	$MainMenuButton.visible = false
	
	$AnimatedSprite2D.play("Booom")

func _on_animated_sprite_2d_animation_finished():
	$AnimationPlayer.play("ShowYouWin")
	$YouWinText.visible = true

func _on_animation_player_animation_finished(anim_name):
	if (anim_name == "ShowYouWin"):
		$AnimationPlayer.play("ShowMainMenuButton")
		$MainMenuButton.visible = true

func _on_main_menu_button_pressed():
	get_tree().change_scene_to_file("res://menus/MainMenu.tscn")
