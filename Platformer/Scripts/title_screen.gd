extends CanvasLayer

# Loads animation player
@onready var animation_player = $AnimationPlayer

# Holds signal for the finished transition. For some reason this doesnt work if
# I put it in Events
signal transition_complete

# Plays the exit animation
func play_exit():
	animation_player.play("Title_Exit")
	
# Plays the enter animation
func play_enter_level():
	animation_player.play("Enter_Level")

func play_title():
	animation_player.play("Title")
	
# Emits a signal when you hit enter or space
signal continued

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		continued.emit()
	
# Emits a signal if the animation finishes
func _on_animation_player_animation_finished(anim_name):
	if anim_name == "Title":
		await continued # Waits for signal when you die
	emit_signal("transition_complete")
