extends CharacterBody2D
class_name Player

enum{
	MOVE,
	CLIMB
}

@export() var moveData: Resource

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var state = MOVE

@onready var sprite = $AnimatedSprite2D
@onready var ladderCheck = $LadderChecker

func _ready():
	pass

func _physics_process(delta):
	var direction = Vector2.ZERO
	direction.x = Input.get_axis("ui_left", "ui_right")
	direction.y = Input.get_axis("ui_up", "ui_down")
	
	match state:
		MOVE: move_state(direction, delta)
		CLIMB: climb_state(direction)
	
func is_on_ladder():
	var collider = ladderCheck.get_collider()
	if not ladderCheck.is_colliding(): return false
	if not collider is Ladder: return false
	return true
	
func move_state(direction, delta):
	if is_on_ladder() and (Input.is_action_pressed("ui_up") or Input.is_action_pressed("ui_accept")):
		state = CLIMB
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	# Handle jump.
	if Input.is_action_pressed("ui_accept") and is_on_floor():
		velocity.y = moveData.JUMP_VELOCITY
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if direction.x > 0:
		sprite.flip_h = true
	elif direction.x < 0:
		sprite.flip_h = false
	if direction.x:
		velocity.x = move_toward(velocity.x,direction.x * moveData.SPEED, moveData.ACCELERATION)
	elif not direction.x and not is_on_floor():
		velocity.x = move_toward(velocity.x,direction.x * moveData.SPEED, moveData.ACCELERATION)
	else:
		velocity.x = move_toward(velocity.x, 0, moveData.FRICTION)
	if is_on_floor() and direction.x:
		sprite.play("run")
	elif is_on_floor() and not direction.x:
		sprite.play("idle")
	elif not is_on_floor():
		sprite.play("jump")
	
	var was_in_air = not is_on_floor()
	var just_landed = is_on_floor() and was_in_air
	if just_landed:
		sprite.play("idle")
	move_and_slide()

func climb_state(direction):
	if not is_on_ladder():
		state = MOVE
	sprite.play("idle")
	velocity = direction * 50
	move_and_slide()
