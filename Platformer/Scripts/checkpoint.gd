extends Area2D

# On ready for loading nodes
@onready var anim_sprite = $AnimatedSprite2D

# Innitializes checkpoint as unchecked
var checked = false 

# Runs when a body enters it
func _on_body_entered(body):
	if not body is Player:
		return # Returns if the body isnt a player
	else: 
		if not checked: # Checks the check point, activates animation, and emits
			checked = true
			anim_sprite.flip_v = false
			anim_sprite.play("Checked")
			Events.emit_signal("checkpoint", position)
		else:
			return
