extends Sprite2D

@onready var exit = $"../PortalCenter"
var active = false

func _ready():
	visible = false
	Events.connect("boss_entered", Callable(self, "_on_boss_enter"))
	Events.connect("boss_defeated", Callable(self, "_on_boss_defeat"))

func _on_area_2d_body_entered(body):
	if (body is Player or body is Boss) and active:
		body.position = exit.get_global_transform().origin

func _on_boss_enter():
	visible = true
	active = true

func _on_boss_defeat():
	visible = false
	active = false
