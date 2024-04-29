extends Node2D

# Loads player as constant
const player_scene = preload("res://Scenes/player.tscn")

var player_start = Vector2.ZERO

# Onready to load nodes
@onready var camera = $Camera2D
@onready var player = $Player
@onready var timer = $Timer

func _ready():
	player.connect_camera(camera) # Connects camera to player
	player_start = player.global_position # Sets player start location
	# Connects to events so it can react to them
	Events.connect("player_died", Callable(self , "_on_player_died"))
	Events.connect("checkpoint", Callable(self, "_on_checkpoint"))
	
# Controls what should happen when you die
func _on_player_died():
	timer.start(1) # Timer so it isnt instant
	await timer.timeout # Waits for timer
	player = player_scene.instantiate() # Instances new player
	player.position = player_start # Sets player to spawn point
	add_child(player) # Adds player child to world
	Events.emit_signal("respawn")
	player.connect_camera(camera) #Reconnects the camera
	
#Controls check point
func _on_checkpoint(checkpoint_position):
	player_start = checkpoint_position
	# Gets checkpoint gloabl position and sets it to the new player spawn
