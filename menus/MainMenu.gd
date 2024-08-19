extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	SaveData.load_data()
	if SaveData.beat_story_mode:
		$ColorRect.visible = false
		var robobakebg = preload("res://worlds/RobotBakesTheEarth.tscn").instantiate()
		add_child(robobakebg)
		robobakebg.get_node("AnimatedSprite2D").play("Idle")
		var audios = robobakebg.get_node("AudioSteams").get_children()
		for a in audios:
			if a != robobakebg.get_node("AudioSteams/ShootingStar"):
				a.volume_db = -10000.0
		robobakebg.get_node("PlayShootingStar").start(randf_range(1,2))
		robobakebg.menu_mode = true
		robobakebg.get_node("YouWinText").queue_free()
		robobakebg.get_node("MainMenuButton").queue_free()
		var stuffs = robobakebg.get_children()
		$Stars.visible = false
		#for i in stuffs:
#			if i.z_order:
	#			i.z_order = -1
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_exit_pressed():
	get_tree().quit()


func _on_start_pressed():
	GlobalVars.is_endless = false
	get_tree().change_scene_to_file("res://worlds/MicroGamePlayer.tscn")


func _on_endless_pressed():
	GlobalVars.is_endless = true
	get_tree().change_scene_to_file("res://worlds/MicroGamePlayer.tscn")
