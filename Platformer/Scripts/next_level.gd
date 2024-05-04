extends Area2D

# Gets a .tscn export
@export_file("*.tscn") var NEXT_LVL: String

# Stores whether the player is on the door or not
var touching = false

func _process(delta):
	# If the player is touching the door, pressed an up action button 
	# (up arrow or w), and there is a next level it goes to the next are
	if touching:
		if Input.is_action_just_pressed("ui_up")  and not NEXT_LVL.is_empty():
			next_area()

func next_area():
	Transition.play_exit() # Plays exit transition
	get_tree().paused = true # Pauses so you dont move while loading
	await Transition.transition_complete # Waits till its done
	get_tree().paused = false # Unpauses
	GlobalVars.has_gun = false
	get_tree().change_scene_to_file(NEXT_LVL) # Changes to next level
	Transition.play_enter() # Plays enter transition

func _on_body_entered(body):
	if body is Player:
		touching = true
	# When the doors area is entered by a player it sets touching as true

func _on_body_exited(body):
	if body is Player:
		touching = false
	# When the doors area is exited by a player it sets touching as true
