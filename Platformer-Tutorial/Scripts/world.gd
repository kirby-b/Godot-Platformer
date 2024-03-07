extends Node2D

const player_scene = preload("res://Scenes/player.tscn")

var player_start = Vector2.ZERO

@onready var camera = $Camera2D
@onready var player = $Player
@onready var timer = $Timer

func _ready():
	player.connect_camera(camera)
	player_start = player.global_position
	Events.connect("player_died", Callable(self , "_on_player_died"))
	Events.connect("checkpoint", Callable(self, "_on_checkpoint"))
	Events.connect("coin_get", Callable(self, "_on_coin_get"))

func _on_player_died():
	timer.start(1)
	await timer.timeout
	var player = player_scene.instantiate()
	player.position = player_start
	add_child(player)
	player.connect_camera(camera)
	
func _on_checkpoint(checkpoint_position):
	player_start = checkpoint_position

func _on_coin_get():
	pass
