extends Base_Game

var has_won : bool = false
var has_lost : bool = false
@onready var guess : Array[Sprite2D] = [null, null, null, null]
@onready var colors : Array[Sprite2D] = [$PatternInit/Red, $PatternInit/Blue, $PatternInit/Green, $PatternInit/Purple]
var curr_index : int = 0
var guess_index : int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	timers = [5,4,3,2]
	directionMessage = "Season!!"
	colors.shuffle()
	print("Order: ", colors[0].name, ", ", colors[1].name, ", ", colors[2].name, ", ", colors[3].name)
	colors[curr_index].visible = true
	$DisplayTimer.start()

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
	guess[guess_index] = $PatternInit/Red
	if guess_index < 4:
		guess_index += 1 

func _on_blue_pressed():
	guess[guess_index] = $PatternInit/Blue
	if guess_index < 4:
		guess_index += 1 

func _on_green_pressed():
	guess[guess_index] = $PatternInit/Green
	if guess_index < 4:
		guess_index += 1 

func _on_purple_pressed():
	guess[guess_index] = $PatternInit/Purple
	if guess_index < 4:
		guess_index += 1 



func _on_display_timer_timeout():
	print("New Color")
	curr_index += 1
	colors[curr_index-1].visible = false
	if curr_index < colors.size():
		colors[curr_index].visible = true 
		$DisplayTimer.start()



