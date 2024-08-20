extends Node2D

var dont_repeat = false
@onready var has_exploded : bool = false
var menu_mode = false
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	menu_mode = false
	$YouWinText.visible = false
	$MainMenuButton.visible = false
	
	$AnimatedSprite2D.play("Booom")
	
	$AudioSteams/Music.play()

func _on_animated_sprite_2d_animation_finished():
	if !dont_repeat and !menu_mode: 
		$AnimationPlayer.play("ShowYouWin")
		$YouWinText.visible = true
	$PlayShootingStar.start(randf_range(0,10))

func _on_animation_player_animation_finished(anim_name):
	if (anim_name == "ShowYouWin"):
		$AnimationPlayer.play("ShowMainMenuButton")
		$MainMenuButton.visible = true
		dont_repeat = true
		
		$AudioSteams/Win.play()

func _on_main_menu_button_pressed():
	get_tree().change_scene_to_file("res://menus/MainMenu.tscn")


func _on_play_shooting_star_timeout():
	$AnimatedSprite2D.play("ShootingStar")
	$AudioSteams/ShootingStar.play()
	
func _on_animated_sprite_2d_frame_changed():
	if $AnimatedSprite2D.frame % 2 == 1 and $AnimatedSprite2D.frame != 1 and not has_exploded:
		$AudioSteams/Laughing.play()
	if $AnimatedSprite2D.frame == 14:
		has_exploded = true
		$AudioSteams/Explosion.play()
	if $AnimatedSprite2D.frame == 26:
		$AudioSteams/ShortCircuit.play()
	elif $AnimatedSprite2D.frame == 38:
		$AudioSteams/ShortCircuit.stop()


func _on_win_finished():
	$AudioSteams/winchiptune.play()
