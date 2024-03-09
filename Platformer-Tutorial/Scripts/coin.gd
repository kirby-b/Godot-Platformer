extends Area2D

@onready var sprite = $AnimatedSprite2D
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	sprite.play("spin")
	


func _on_body_entered(body):
	if body is Player:
		SoundPlayer.play_sound(SoundPlayer.COIN)
		queue_free()
		Events.emit_signal("coin_get")
