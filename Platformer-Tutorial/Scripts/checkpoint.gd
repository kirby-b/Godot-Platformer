extends Area2D

@onready var anim_sprite = $AnimatedSprite2D

var checked = false 

func _on_body_entered(body):
	if not body is Player:
		return
	else: 
		if not checked:
			checked = true
			anim_sprite.flip_v = false
			anim_sprite.play("Checked")
			Events.emit_signal("checkpoint", position)
		else:
			return
