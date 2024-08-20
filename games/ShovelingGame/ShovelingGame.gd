extends Base_Game

var has_won : bool = false
var has_lost : bool = false
@onready var shovel_pos : Array[bool] = [true, false, false]
@export var cycles_to_win : int
var total_cycles : int
@onready var cycleslabel = $Cycles_Label
@onready var sprites : Array[CompressedTexture2D]
# Called when the node enters the scene tree for the first time.
func _ready():
	timers = [6,5,4,3,2]
	directionMessage = "Shovel!!"
	setupSprites()
	cycleslabel.text = "Shovels left: %01d" % cycles_to_win
	cycles_to_win = randi_range(4, 6)
	$Shovel.position = Vector2i(80,90)
	$W.visible = true

func setupSprites():
	if GlobalVars.game_stage == 0:
		sprites.append(load("res://assets/sprites/shovel.png"))
		sprites.append(load("res://assets/sprites/coal.png"))
	if GlobalVars.game_stage == 1:
		sprites.append(load("res://assets/sprites/shovel.png"))
		sprites.append(load("res://assets/sprites/gas.png"))
	if GlobalVars.game_stage == 2:
		sprites.append(load("res://assets/sprites/shovel.png"))
		sprites.append(load("res://assets/sprites/beegisland.png"))
	$Shovel.texture = sprites[0]
	$Coal_Left.texture = sprites[1]
	$Coal_Right.texture = sprites[1]

func _input(event):
	if event.is_action_pressed("A"):
		if shovel_pos[1] and $A.visible and not has_won:
			$shovelingSFX.play()
			$W.visible = true
			$A.visible = false
			shovel_pos[0] = true
			shovel_pos[1] = false
			total_cycles += 1
			$Shovel.position = Vector2i(80,90)
			$Shovel.rotate(4.71239)
		else:
			super.onLose()
	elif event.is_action_pressed("W") and not has_won:
		if shovel_pos[0] and $W.visible:
			$D.visible = true
			$W.visible = false
			shovel_pos[0] = false
			shovel_pos[1] = true
			$Shovel.position = Vector2i(114,50)
			$fireSFX.play()
			$Shovel.rotation_degrees = rad_to_deg(PI)
		elif shovel_pos[2] and $W.visible:
			$A.visible = true
			$W.visible = false
			shovel_pos[2] = false
			shovel_pos[1] = true
			$Shovel.position = Vector2i(114,50)
			$fireSFX.play()
			$Shovel.rotation_degrees = rad_to_deg(PI)
		else:
			super.onLose()
	elif event.is_action_pressed("D") and not has_won:
		if shovel_pos[1] and $D.visible:
			$shovelingSFX.play()
			$W.visible = true
			$D.visible = false
			shovel_pos[2] = true
			shovel_pos[1] = false
			$Shovel.position = Vector2i(152,90)
			$Shovel.rotate(PI/2)
		else:
			super.onLose()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	cycleslabel.text = "Shovels left: %01d" % (cycles_to_win-total_cycles)
	if total_cycles >= cycles_to_win and not has_won:
		super.onWin()
		has_won = true
