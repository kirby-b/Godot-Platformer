extends Area2D

#Onready for loading nodes
@onready var sprite = $AnimatedSprite2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	sprite.play("spin")

# Runs when a body enters it
func _on_body_entered(body):
	if body is Player: #If it is the player, it makesa sound, disappears, and emits
		SoundPlayer.play_sound(SoundPlayer.COIN)
		queue_free()
		Events.emit_signal("coin_get")
