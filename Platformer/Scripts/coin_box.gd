extends StaticBody2D

# This will all control the block giving the player a coin and deactivating.
# I admit my method may be a little jank, but it should work fine

# States for whether the box is active or not
enum{
	ACTIVE,
	DEACTIVE
}

# On ready variables to access nodes
@onready var sprite = $AnimatedSprite2D
@onready var hit_detect = $GetHitBoi

var state = ACTIVE # Holds the current state

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	match state:
		ACTIVE:
			active()
		DEACTIVE:
			deactivated()

func active():
	sprite.play("full")
	
	
func deactivated():
	sprite.play("empty")
