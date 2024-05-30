extends StaticBody2D


# Similar to coin and item, but just for visibity
var is_visible = false

# On ready variables to access nodes
@onready var sprite = $Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	Events.connect("boss_entered", Callable(self, "_on_boss_room_entered"))
	Events.connect("boss_defeated", Callable(self, "_on_boss_defeated"))


# Called when the node enters the scene tree for the first time.
func _physics_process(delta):
	sprite.visible = is_visible

func _on_boss_room_entered():
	is_visible = true
	collision_mask = 2
	
func _on_boss_defeated():
	is_visible = false
	collision_mask = 0
	
