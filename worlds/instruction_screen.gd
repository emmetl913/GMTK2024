extends Control

var times_faded : int = 1

func _ready():
	$AnimationPlayerFirst.play("fade_to_normal")
	$Timer.start()
func _on_timer_timeout():
	if times_faded == 1:
		$AnimationPlayerFirst.play("fade_to_normal2")
		times_faded += 1
		$Timer.start()
	elif times_faded == 2:
		$AnimationPlayerFirst.play("fade_to_normal3")
		times_faded += 1
		$Timer.start()
	elif times_faded == 3:
		$AnimationPlayerFirst.play("fade_to_black")
		times_faded += 1
		$Timer.start()
	elif times_faded == 4:
		$AnimationPlayerFirst.play("fade_to_black2")
		times_faded += 1
		$Timer.start()
	elif times_faded == 5:
		$AnimationPlayerFirst.play("fade_to_black3")
		times_faded += 1
		$Timer.start()

func _input(event):
	if event.is_action_pressed("LMB"):
		get_tree().change_scene_to_file("res://menus/MainMenu.tscn")

func _on_animation_player_first_animation_finished(anim_name):
	if anim_name == "fade_to_black3":
		get_tree().change_scene_to_file("res://menus/MainMenu.tscn")
