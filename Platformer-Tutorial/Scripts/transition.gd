extends CanvasLayer

@onready var animation_player = $AnimationPlayer

signal transition_complete

func play_exit():
	animation_player.play("Exit")
	
func play_enter():
	animation_player.play("Enter")
	
func _on_animation_player_animation_finished(anim_name):
	emit_signal("transition_complete")
