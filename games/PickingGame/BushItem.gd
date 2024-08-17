extends Node2D

var in_range = false

func _on_area_2d_area_entered(area):
	if area.is_in_group("Cursor"):
		in_range = true


func _on_area_2d_area_exited(area):
	if area.is_in_group("Cursor"):
		in_range = false
