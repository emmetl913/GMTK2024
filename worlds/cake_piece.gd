extends Node2D

class_name CakePiece

@export var cutscene: Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	print(position)
	print(z_index)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func setCutscene(cut: Node2D):
	cutscene = cut

func playAnimation():
	$AnimationPlayer.play("Falling")

func _on_animation_player_animation_finished(anim_name):
	cutscene.endCutscene()

func setTexture(texture: Texture2D):
	$Sprite2D.texture = texture
