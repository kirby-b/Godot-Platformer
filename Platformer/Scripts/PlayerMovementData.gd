extends Resource
class_name PlayerMovementData

@export var SPEED: int = 110.0 # Max Speed
@export var JUMP_VELOCITY: int = -350.0 # Jump height/speed
@export var ACCELERATION: int = 10 # How fast you move towards max speed
@export var FRICTION: int = 20 # How fast you slow down to stop
@export var CLIMB_SPEED: int = 60 # How fast you are on ladders
@export var EXTRA_JUMPS: int = 1 # How many jumps you get after the first
