extends CharacterBody2D
class_name Boss

@onready var lazer_delay = $LazerDelay
@onready var fire_point = $LazerSpawn
@onready var sprite = $AnimatedSprite2D

# Gets the lazer scene for instancing
@export var Lazer : PackedScene
@export() var speed: float

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction = 1
var can_fire = true
var life = 10

func _physics_process(delta):
	if GlobalVars.activeboss == true:
		if can_fire:
			shoot()
		# Set boss position to random tube point
		# Adds the gravity.
		if not is_on_floor():
			velocity.y += gravity * delta
		# Detects if they hit a wall
		var found_wall = is_on_wall() 
		
		# Changes direction if they find a wall of ledge
		if found_wall:
			direction *= -1
		# Gets the flip with a simple boolean
		sprite.flip_h = direction > 0
		
		sprite.play("walk") # Constantly plays the walk
		velocity.x = direction * speed # Constant speed
		
		if direction > 0:
			fire_point.position = Vector2(17, -1)
		elif direction < 0:
			fire_point.position = Vector2(-17, -1)
		
		move_and_slide()

# Makes the gun shoot
func shoot():
	var l = Lazer.instantiate()
	l.set_target("characters")
	l.aim(direction)
	get_tree().current_scene.add_child(l)
	l.transform = fire_point.global_transform
	SoundPlayer.play_sound(SoundPlayer.BANG)
	can_fire = false
	lazer_delay.start()

func _on_lazer_delay_timeout():
	can_fire = true
	
# Makes the boss lose a life
func lose_life():
	life -= 1
	if life <= 0:
		SoundPlayer.play_sound(SoundPlayer.HURT)
		queue_free()
