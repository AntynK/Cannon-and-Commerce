extends CharacterBody2D

const ACCELERATION_RATE = 55
const ROTATION_RATE = 45
const FRICTION = 35
const MAX_VELOCITY = 100

func _physics_process(delta: float) -> void:
	var direction: Vector2 = get_direction()
	
	if Input.is_action_pressed("forward") and velocity.length() <= MAX_VELOCITY:
		velocity += delta * ACCELERATION_RATE * direction
	if Input.is_action_pressed("backward") and velocity.length() <= MAX_VELOCITY:
		velocity -= delta * ACCELERATION_RATE * direction
	if Input.is_action_pressed("right"):
		rotate(deg_to_rad(ROTATION_RATE) * delta)
		velocity = velocity.rotated(deg_to_rad(ROTATION_RATE) * delta)
	if Input.is_action_pressed("left"):
		rotate(deg_to_rad(-ROTATION_RATE) * delta)
		velocity = velocity.rotated(deg_to_rad(-ROTATION_RATE) * delta)
	if velocity.length() > 0:
		move_and_slide()
		velocity = velocity.move_toward(Vector2.ZERO, delta * FRICTION)
	
func get_direction() -> Vector2:
	return Vector2(cos(rotation), sin(rotation))
