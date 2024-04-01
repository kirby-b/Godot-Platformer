extends Area2D

#Onready for loading nodes
@onready var sprite = $AnimatedSprite2D

# Runs when a body enters it
func _on_body_entered(body):
	if body is Player: #If it is the player, it makesa sound, disappears, and emits
		SoundPlayer.play_sound(SoundPlayer.COIN)
		queue_free()
		Events.emit_signal("diamond_get")
