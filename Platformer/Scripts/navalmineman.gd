extends Path2D

# States for the enemy
enum ANIM_TYPE{
	PONG,
	LOOP
}

# Exports variables for enemy
@export() var animation: ANIM_TYPE
@export() var anim_speed: float = 1.0

# Onready for loading nodes
@onready var anim_player = $AnimationPlayer

func _ready():
	anim_player.speed_scale = anim_speed # Adjusts speed from export var
	match animation: # Matchs state to determine animation type
		ANIM_TYPE.LOOP: anim_player.play("MovementPathLoop")
		ANIM_TYPE.PONG: anim_player.play("MovementPathBounce")
