extends Area2D

var active = true


func _on_body_entered(body):
	if active and body is Player:
		Events.emit_signal("boss_entered")
		GlobalVars.activeboss = true
		active = false
