extends Area2D

@export_file("*.tscn") var NEXT_LVL: String

var touching = false

func _process(delta):
	if touching:
		if Input.is_action_just_pressed("ui_up")  and not NEXT_LVL.is_empty():
			next_area()

func next_area():
	Transition.play_exit()
	get_tree().paused = true
	await Transition.transition_complete
	get_tree().paused = false
	get_tree().change_scene_to_file(NEXT_LVL)
	Transition.play_enter()

func _on_body_entered(body):
	if body is Player:
		touching = true

func _on_body_exited(body):
	if body is Player:
		touching = false
