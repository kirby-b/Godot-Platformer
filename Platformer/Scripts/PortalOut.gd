extends Sprite2D

func _ready():
	pass

func _physics_process(_delta):
	Events.connect("boss_entered", Callable(self, "_on_boss_enter"))
	Events.connect("boss_defeated", Callable(self, "_on_boss_defeat"))

func _on_boss_enter():
	pass

func _on_boss_defeat():
	pass
