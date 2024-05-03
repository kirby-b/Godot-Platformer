extends Path2D

# States for the enemy. I may end up with more later
enum ANIM_TYPE{
	LOOP
}

# Exports variables for enemy
@export() var animation: ANIM_TYPE
@export() var anim_speed: float = 1.0
@export() var life: int = 2

# Onready for loading nodes
@onready var anim_player = $AnimationPlayer

func _ready():
	anim_player.speed_scale = anim_speed # Adjusts speed from export var
	match animation: # Matchs state to determine animation type
		ANIM_TYPE.LOOP: anim_player.play("MovementPathLoop")

func lose_life():
	life -= 1
	if life <= 0:
		queue_free()
