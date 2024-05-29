extends CharacterBody2D

@onready var lazer_delay = $LazerDelay
@onready var fire_point = $LazerSpawn
var can_fire = true

# Gets the lazer scene for instancing
@export var Lazer : PackedScene
var aim_direction = 1

func _physics_process(delta):
	if GlobalVars.activeboss == true:
		for n in 4:
			shoot()
			await can_fire
			aim_direction *= -1
		#Set boss position to random tube point

# Makes the gun shoot
func shoot():
	var l = Lazer.instantiate()
	l.aim(aim_direction)
	get_tree().current_scene.add_child(l)
	l.transform = fire_point.global_transform
	SoundPlayer.play_sound(SoundPlayer.BANG)
	can_fire = false
	lazer_delay.start()

func _on_lazer_delay_timeout():
	can_fire = true
