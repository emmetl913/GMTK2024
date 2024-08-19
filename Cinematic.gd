extends Node2D

var parent

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func setParent(par: Node2D):
	parent = par

func playAnimation():
	$AnimationPlayer.play("Cinematic")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_animation_player_animation_finished(anim_name):
	parent.endCinematic()
