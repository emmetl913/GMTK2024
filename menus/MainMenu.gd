extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


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
