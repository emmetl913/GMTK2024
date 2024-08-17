extends Base_Game

@export var max_right: float
@export var max_left: float
var dir: float = 1.0
@export var speed: float
@export var shaver_speed: float

var move_shaver = false
var is_shaver_down = false

var shaver_dir: float = 1.0

var shave_count: int = 0
var num_to_shave = 2

var has_result = false
func _ready():
	#GameSetup
	timers = [5, 4, 3, 2]
	directionMessage = "SHAVE!!"
	if randi_range(1,2) == 1:
		num_to_shave = 3
		addExtraShaveable()
func addExtraShaveable():
	$Shaveables/Sprite2D4/Area2D/CollisionShape2D.disabled = false
	$Shaveables/Sprite2D4.visible = true
	if randi_range(1,2) == 1:
		#Add to the left position
		$Shaveables/Sprite2D4.position.x = -115
	else:
		#Right position
		$Shaveables/Sprite2D4.position.x = 115
func _process(delta):
	if $Shaveables.position.x > max_right:
		dir = -1.0
	elif $Shaveables.position.x < max_left:
		dir = 1.0
	#lerp
	$Shaveables.position += Vector2(1.0 * dir * speed * delta, 0)
	
	if move_shaver and ($Shaver.position.y <= 140 and $Shaver.position.y >= 20):
		$Shaver.position.y += 1.0 * shaver_dir * shaver_speed * delta
	else:
		move_shaver = false
func _input(event):
	if event.is_action_pressed("LMB"):
		if !move_shaver:
			slideShaver()
		
func slideShaver():
	move_shaver = true
	is_shaver_down = !is_shaver_down
	#lerp y 
	if is_shaver_down:
		shaver_dir = 1.0
		$Shaver.position.y = 20
	else:
		shaver_dir = -1.0
		$Shaver.position.y = 140


func _on_shave_area_area_entered(area):
	if area.is_in_group("ShaveLose") and !has_result:
		area.get_parent().self_modulate = Color.DARK_RED
		super.onLose()
		has_result = true
	elif area.is_in_group("CleanShave") and !has_result:
		shave_count += 1
		area.get_parent().queue_free()
		if shave_count == num_to_shave:
			super.onWin()
			has_result = true
