extends Sprite2D

func _ready():
	visible = false
	Events.connect("boss_entered", Callable(self, "_on_boss_enter"))
	Events.connect("boss_defeated", Callable(self, "_on_boss_defeat"))
	
func _on_boss_enter():
	visible = true

func _on_boss_defeat():
	visible = false
