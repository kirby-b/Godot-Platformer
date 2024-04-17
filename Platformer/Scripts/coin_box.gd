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
	if is_player():
		Events.emit_signal("coin_get")
		# Basically I want to check if the collider is player, then I need to check if they are in 
		# the air. If all that passes, it gives the player a coin.
	
func deactivated():
	sprite.play("empty")

# Checks whether the player is on a ladder
func is_player():
	var collider = hit_detect.get_collider()
	if not hit_detect.is_colliding(): return false
	if not collider is Player: return false
	return true
