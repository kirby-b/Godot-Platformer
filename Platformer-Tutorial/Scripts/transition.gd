extends CanvasLayer

# Loads animation player
@onready var animation_player = $AnimationPlayer

# Holds signal for the finished transition. For some reason this doesnt work if
# I put it in Events
signal transition_complete

# Plays the exit animation
func play_exit():
	animation_player.play("Exit")
	
# Plays the enter animation
func play_enter():
	animation_player.play("Enter")
	
# Emits a signal if the animation finishes
func _on_animation_player_animation_finished(anim_name):
	emit_signal("transition_complete")
