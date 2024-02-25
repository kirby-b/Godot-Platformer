extends Path2D

enum ANIM_TYPE{
	PONG,
	LOOP
}

@export() var animation: ANIM_TYPE
@export() var anim_speed: float = 1.0

@onready var anim_player = $AnimationPlayer

func _ready():
	anim_player.speed_scale = anim_speed
	match animation:
		ANIM_TYPE.LOOP: anim_player.play("MovementPathLoop")
		ANIM_TYPE.PONG: anim_player.play("MovementPathBounce")
