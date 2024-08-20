extends Base_Game

var has_won : bool = false
var has_lost : bool = false
@onready var guess : Array[Sprite2D] = [null, null, null, null]
@onready var colors : Array[Sprite2D] = [$PatternInit/Red, $PatternInit/Blue, $PatternInit/Green, $PatternInit/Purple]
var curr_index : int = 0
var guess_index : int = 0
@onready var sprites : Array[CompressedTexture2D]
# Called when the node enters the scene tree for the first time.
func _ready():
	timers = [5,4,3,2]
	directionMessage = "Season!!"
	setupSprites()
	colors.shuffle()
	print("Order: ", colors[0].name, ", ", colors[1].name, ", ", colors[2].name, ", ", colors[3].name)
	colors[curr_index].visible = true
	playSound(colors[curr_index])
	$DisplayTimer.start()

func setupSprites():
	if GlobalVars.game_stage == 0:
		sprites.append(load("res://assets/sprites/saltshaker.png"))
		sprites.append(load("res://assets/sprites/pepshaker.png"))
		sprites.append(load("res://assets/sprites/pinkshaker.png"))
		sprites.append(load("res://assets/sprites/brownshaker.png"))
		$DisplayTimer.wait_time = 0.5
	elif GlobalVars.game_stage == 1:
		sprites.append(load("res://assets/sprites/bolt1.png"))
		sprites.append(load("res://assets/sprites/bolt2.png"))
		sprites.append(load("res://assets/sprites/nutt.png"))
		sprites.append(load("res://assets/sprites/worsher.png"))
		$DisplayTimer.wait_time = 0.3
	elif GlobalVars.game_stage == 2:
		sprites.append(load("res://assets/sprites/fire.png"))
		sprites.append(load("res://assets/sprites/wooder.png"))
		sprites.append(load("res://assets/sprites/erf.png"))
		sprites.append(load("res://assets/sprites/wind.png"))
	$PatternInit/Red.texture = sprites[0]
	$PatternDisplay/Red.texture_normal = sprites[0]
	$PatternInit/Blue.texture = sprites[1]
	$PatternDisplay/Blue.texture_normal = sprites[1]
	$PatternInit/Green.texture = sprites[2]
	$PatternDisplay/Green.texture_normal = sprites[2]
	$PatternInit/Purple.texture = sprites[3]
	$PatternDisplay/Purple.texture_normal = sprites[3]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if guess_index > 3 and arrays_have_same_content(guess, colors) and not has_won:
		super.onWin()
		has_won = true
	elif guess_index > 3 and not arrays_have_same_content(guess, colors) and not has_lost:
		super.onLose()
		has_lost = true

func arrays_have_same_content(array1, array2):
	if array1.size() != array2.size(): return false
	for item in array1:
			if !array2.has(item): return false
			if array1.count(item) != array2.count(item): return false
	return true

func _on_red_pressed():
	if guess_index < 4:
		guess[guess_index] = $PatternInit/Red
		guess_index += 1 
		$Node/Red.play()

func _on_blue_pressed():
	if guess_index < 4:
		guess[guess_index] = $PatternInit/Blue
		guess_index += 1 
		$Node/Blue.play()

func _on_green_pressed():
	if guess_index < 4:
		guess[guess_index] = $PatternInit/Green
		guess_index += 1 
		$Node/Green.play()

func _on_purple_pressed():
	if guess_index < 4:
		guess[guess_index] = $PatternInit/Purple
		guess_index += 1 
		$Node/Purp.play()



func _on_display_timer_timeout():
	print("New Color")
	curr_index += 1
	colors[curr_index-1].visible = false
	if curr_index < colors.size():
		playSound(colors[curr_index])
		colors[curr_index].visible = true 
		playSound(colors[curr_index])
		$DisplayTimer.start()

func playSound(color : Sprite2D):
	if color == $PatternInit/Red:
		$Node/Red.play()
	elif color == $PatternInit/Blue:
		$Node/Blue.play()
	elif color == $PatternInit/Green:
		$Node/Green.play()
	elif color == $PatternInit/Purple:
		$Node/Purp.play()

