extends Node2D

var microGamePlayer

@export var phase_1_textures : Array[Texture2D]

# Called when the node enters the scene tree for the first time.
func _ready():
	setUpCake()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func setUpCake():
	if (microGamePlayer.total_wins + microGamePlayer.total_losses <= 0):
		$Buffer.start()
		return
	
	#Add new cake layer to array
	if (microGamePlayer.recentGameWon):
		var randIndex = randi_range(0, 2)
		microGamePlayer.cake_layers.append(randIndex)
	else:
		microGamePlayer.cake_layers.append(3)
	
	#Move background down depending on number of cake layers
	$Background.position.y = -160 + (6 * microGamePlayer.cake_layers.size())
	
	#Instantiate cake layers
	var newestCakeLayer
	var bottomLayerY = $Background.position.y + 275
	print(microGamePlayer.cake_layers)
	for i in microGamePlayer.cake_layers.size():
		print(i)
		newestCakeLayer = microGamePlayer.cakeLayerScene.instantiate()
		newestCakeLayer.setCutscene(self)
		
		newestCakeLayer.position.x = 120
		newestCakeLayer.position.y = bottomLayerY - (6 * i)
		
		#change layer texture
		newestCakeLayer.setTexture(phase_1_textures[microGamePlayer.cake_layers[i]])
		
		add_child(newestCakeLayer, true)
	
	#Animate newest cake layer
	newestCakeLayer.playAnimation()

func setMicroGamePlayer(mgp: Node2D):
	microGamePlayer = mgp

func endCutscene():
	microGamePlayer.exit_cutscene()

func _on_buffer_timeout():
	endCutscene()
