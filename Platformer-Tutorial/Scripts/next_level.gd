extends Area2D

@export_file("*.tscn") var NEXT_LVL: String


func _on_body_entered(body):
	if body is Player and not NEXT_LVL.is_empty():
		get_tree().change_scene_to_file(NEXT_LVL)
