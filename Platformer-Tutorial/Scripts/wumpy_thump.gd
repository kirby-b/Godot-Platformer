extends Node2D

enum{
	CRUSH,
	RISE,
	IDLE,
	LAND
}
var state = IDLE

@onready var start_pos = global_position
@onready var timer = $Timer
@onready var detect_floor = $RayCast2D
@onready var sprite = $AnimatedSprite2D
@onready var particles = $GPUParticles2D

func _ready():
	particles.one_shot = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	match state:
		CRUSH: crush(delta)
		RISE: rise(delta)
		IDLE: idle()
		LAND: land()
	
func idle():
	sprite.play("idle")
	if timer.time_left == 0:
		state = CRUSH
	
func crush(delta):
	sprite.play("crush")
	if detect_floor.is_colliding() == false:
		position.y += 200 * delta
	else:
		particles.emitting = true
		SoundPlayer.play_sound(SoundPlayer.BOOM)
		state = LAND
		timer.start(1)
	
func rise(delta):
	particles.emitting = false
	sprite.play("idle")
	position.y = move_toward(position.y, start_pos.y, 50 * delta)
	if position.y == start_pos.y:
		state = IDLE
		timer.start(2)

func land():
	sprite.play("idle")
	if timer.time_left == 0:
		state = RISE
