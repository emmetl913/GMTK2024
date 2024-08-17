extends Base_Game

var bushItems: Array[Node2D]
var bushItem = preload("res://games/PickingGame/BushItem.tscn")
@export var spawnRange: Vector2
@export var spawnCountRandomRange: Vector2

var centerScreenOffset = Vector2(120,80)
var all_bad = true
var has_won = false
#TODO:
	#if picking game has all bad berries wait timer to win
func _ready():
	#GameSetup
	directionMessage = "PICK!!"
	timers = [5, 4, 3, 2]

	for i in randi_range(spawnCountRandomRange.x,spawnCountRandomRange.y):
		var newItem = bushItem.instantiate()
		newItem.position =Vector2(centerScreenOffset.x + randf_range(spawnRange.x,spawnRange.y), centerScreenOffset.y +  + randf_range(spawnRange.x,spawnRange.y)/2)
		add_child(newItem)

	for i in get_children():
		if i.is_in_group("BushItem"):
			bushItems.append(i)
	for i in bushItems:
		if i.is_good:
			all_bad = false
	if all_bad:
		bushItems[0].setGood()
func _input(event):
	if event.is_action_pressed("LMB"):
		#Check to see if any thing is under mouse
		var any_in_range = false
		for i in bushItems:
			if i.isInRange():
				any_in_range = true

		for i in bushItems:
			if !i.is_good and i.isInRange():
				for j in bushItems:
					j.self_modulate = Color.DARK_RED
				super.onLose()
			if i.isInRange() and i.is_good:
				i.successState()
	if checkWin() and !has_won:
		super.onWin()
		has_won = true
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func checkWin():
	var win = true
	for i in bushItems:
		if i.is_good and !i.success:
			win = false
	return win


