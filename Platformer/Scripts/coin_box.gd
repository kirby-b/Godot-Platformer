extends StaticBody2D

# This will all control the block giving the player a coin and deactivating.
# I admit my method may be a little jank, but it should work fine

# States for whether the box is active or not
enum{
	ACTIVE,
	DEACTIVE
}

# Exports 
@export() var coins_in_box: int = 1

# On ready variables to access nodes
@onready var sprite = $AnimatedSprite2D
@onready var collect_buffer = $CollectBuffer

var state = ACTIVE # Holds the current state

# Called when the node enters the scene tree for the first time.
func _physics_process(delta):
	if state == ACTIVE:
		sprite.play("full")
	elif state == DEACTIVE:
		sprite.play("empty")

func _on_get_hit_boi_body_entered(body):
	if state == ACTIVE:
		sprite.play("full")
		if body is Player and coins_in_box > 0:
			Events.emit_signal("coin_get")
			SoundPlayer.play_sound(SoundPlayer.COIN)
			coins_in_box -= 1
			if coins_in_box <= 0:
				state = DEACTIVE
				sprite.play("empty")
			collect_buffer.start()
			await collect_buffer.timeout
			# Basically I want to check if the body is player, then I need to 
			# check if they are in the air. If all that passes, it gives the 
			# player a coin.
