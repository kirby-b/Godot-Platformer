extends StaticBody2D

# Similar to coin and item, but just for visibity
var is_visible = false

# On ready variables to access nodes
@onready var sprite = $Sprite2D

# Called when the node enters the scene tree for the first time.
func _physics_process(delta):
	sprite.visible = is_visible

func _on_get_hit_boi_body_entered(body):
	if is_visible == false:
		is_visible = true
		sprite.visible = true
			# Basically I want to check if the body is player, then I need to 
			# check if they are in the air. If all that passes, it becomes visible
