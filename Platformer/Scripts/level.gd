extends Node2D

# Loads player as constant
const player_scene = preload("res://Scenes/player.tscn")

var player_start = Vector2.ZERO

# Onready to load nodes
@onready var camera = $Camera2D
@onready var player = $Player
@onready var timer = $Timer

func _ready():
	if GlobalVars.started_game == false:
		get_tree().paused = true
		TitleScreen.play_title()
		await TitleScreen.transition_complete # Waits till its done
		TitleScreen.play_exit()
		await TitleScreen.transition_complete # Waits till its done
		timer.start(1) # Timer so it isnt instant
		TitleScreen.play_enter_level()
		await TitleScreen.transition_complete # Waits till its done
		GlobalVars.started_game = true
		get_tree().paused = false
	player.connect_camera(camera) # Connects camera to player
	player_start = player.global_position # Sets player start location
	# Connects to events so it can react to them
	Events.connect("player_died", Callable(self , "_on_player_died"))
	Events.connect("checkpoint", Callable(self, "_on_checkpoint"))
	
# Controls what should happen when you die
func _on_player_died():
	if !(GlobalVars.lives <= 0):
		GlobalVars.lives -= 1
		timer.start(1) # Timer so it isnt instant
		await timer.timeout # Waits for timer
		player = player_scene.instantiate() # Instances new player
		player.position = player_start # Sets player to spawn point
		add_child(player) # Adds player child to world
		Events.emit_signal("respawn")
		player.connect_camera(camera) # Reconnects the camera
	else:
		GlobalVars.lives = 3
		GlobalVars.coins_lower = 0
		GlobalVars.coins_upper = 0
		timer.start(1) # Timer so it isnt instant
		await timer.timeout # Waits for timer
		Transition.play_game_over() # Plays exit transition
		get_tree().paused = true # Pauses so you dont move while loading
		await Transition.transition_complete # Waits till its done
		get_tree().paused = false # Unpauses
		GlobalVars.has_gun = false
		get_tree().change_scene_to_file("res://Scenes/Levels/w1_l1.tscn") # Changes to next level
		Transition.play_enter() # Plays enter transition
	
# Controls check point
func _on_checkpoint(checkpoint_position):
	player_start = checkpoint_position
	# Gets checkpoint gloabl position and sets it to the new player spawn
