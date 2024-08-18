extends Node

var save_path = "user://variable.save"

@export var best_streak : int = 0

func save(newtime : int):
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	if newtime > best_streak:
		best_streak = newtime
		print("Saving ", best_streak, " as current best streak")
		file.store_var(best_streak)
		print("Save successful!")
	file.close()

func load_data():
	if FileAccess.file_exists(save_path):
		var file = FileAccess.open(save_path, FileAccess.READ)
		best_streak = file.get_var()
		file.close()
