extends Node

@onready var enter = $In
@onready var middle = $In/Middle
@onready var exit = $Out

var can_teleport = false
var player

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if can_teleport == true and Input.is_action_just_pressed("ui_down"):
		player.position = middle.get_global_transform().origin
		Transition.play_exit() # Plays exit transition
		get_tree().paused = true # Pauses so you dont move while loading
		await Transition.transition_complete # Waits till its done
		get_tree().paused = false # Unpauses
		Transition.play_enter() # Plays enter transition
		player.position = exit.get_global_transform().origin


func _on_in_body_entered(body):
	if body is Player:
		can_teleport = true
		player = body


func _on_in_body_exited(body):
	if body is Player:
		can_teleport = false
