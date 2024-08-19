extends Node2D

var dont_repeat = false
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	$YouWinText.visible = false
	$MainMenuButton.visible = false
	
	$AnimatedSprite2D.play("Booom")

func _on_animated_sprite_2d_animation_finished():
	if !dont_repeat: 
		$AnimationPlayer.play("ShowYouWin")
		$YouWinText.visible = true
	$PlayShootingStar.start(randf_range(0,10))

func _on_animation_player_animation_finished(anim_name):
	if (anim_name == "ShowYouWin"):
		$AnimationPlayer.play("ShowMainMenuButton")
		$MainMenuButton.visible = true
		dont_repeat = true
		
func _on_main_menu_button_pressed():
	get_tree().change_scene_to_file("res://menus/MainMenu.tscn")


func _on_play_shooting_star_timeout():
	$AnimatedSprite2D.play("ShootingStar")
