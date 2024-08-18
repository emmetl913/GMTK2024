extends Base_Game

var count : int = 0
var total_offscreen : int = 0
var has_won : bool = false
@onready var sprites : Array[CompressedTexture2D]
# Called when the node enters the scene tree for the first time.
func _ready():
	timers = [5, 4, 3, 2]
	directionMessage = "CLEAN!!"
	setupSprites()
	$Label.text = "%02d" % count

func setupSprites():
	if GlobalVars.game_stage == 0:
		sprites.append(load("res://assets/sprites/slime.png"))
		sprites.append(load("res://assets/sprites/rollingpin.png"))
		sprites.append(load("res://assets/sprites/eggshells.png"))
	$Trash_Box/Trash/Sprite2D.texture = sprites[0]
	$Trash_Box/Trash2/Sprite2D.texture = sprites[2]
	$Trash_Box/Trash3/Sprite2D.texture = sprites[2]
	$Trash_Box/Trash4/Sprite2D.texture = sprites[1]
	$Trash_Box/Trash5/Sprite2D.texture = sprites[0]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$CharacterBody2D.position = get_global_mouse_position()
	if count > 1:
		$Win.stop()

func _on_area_2d_body_entered(body):
	count += 1
	$Label.text = "%02d" % count


func _on_area_2d_body_exited(body):
	count -= 1
	$Label.text = "%02d" % count
	if count <= 1 and not has_won:
		super.onWin()
		has_won = true
