extends Sprite2D

@onready var exit = $"../PortalCenter"

func _ready():
	pass

func _physics_process(_delta):
	Events.connect("boss_entered", Callable(self, "_on_boss_enter"))
	Events.connect("boss_defeated", Callable(self, "_on_boss_defeat"))

func _on_area_2d_body_entered(body):
	if body is Player or body is Boss:
		body.position = exit.get_global_transform().origin

func _on_boss_enter():
	pass

func _on_boss_defeat():
	pass
