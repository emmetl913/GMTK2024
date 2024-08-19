extends Base_Game

var bushItems: Array[Node2D]
var bushItem = preload("res://games/PickingGame/BushItem.tscn")
@export var spawnRange: Vector2
@export var spawnCountRandomRange: Vector2
@onready var sprites : Array[CompressedTexture2D]

var centerScreenOffset = Vector2(120,80)
var all_bad = true
var has_won = false
#TODO:
	#if picking game has all bad berries wait timer to win
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	for i in randi_range(spawnCountRandomRange.x,spawnCountRandomRange.y):
		var newItem = bushItem.instantiate()
		newItem.position =Vector2(centerScreenOffset.x + randf_range(spawnRange.x,spawnRange.y), centerScreenOffset.y +  + randf_range(spawnRange.x,spawnRange.y)/2)
		add_child(newItem)
	setupSprites()
	#Setup timers
	timers = [5, 4, 3, 2]
	directionMessage = "PICK!!"
	
	for i in get_children():
		if i.is_in_group("BushItem"):
			bushItems.append(i)
	for i in bushItems:
		if i.is_good:
			i.texture = sprites[0]
			all_bad = false
		else:
			i.texture = sprites[1]
	if all_bad:
		bushItems[0].setGood()

func setupSprites():
	if GlobalVars.game_stage == 0:
		sprites.append(load("res://assets/sprites/strawberry.png"))
		sprites.append(load("res://assets/sprites/strawberrybad.png"))

func _input(event):
	if event.is_action_pressed("LMB"):
		#Check to see if any thing is under mouse
		var any_in_range = false
		for i in bushItems:
			if i.isInRange():
				any_in_range = true
				$grabSFX.play()

		for i in bushItems:
			if !i.is_good and i.isInRange():
				for j in bushItems:
					j.self_modulate = Color.DARK_RED
				Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
				super.onLose()
			if i.isInRange() and i.is_good:
				i.successState()
	if checkWin() and !has_won:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
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


