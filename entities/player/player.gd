extends CharacterBody2D

const ACCELERATION_RATE := 100
const ROTATION_RATE := 45
const FRICTION := 35
const MAX_VELOCITY := 150

@onready var DockingTimer: Timer = $DockingTimer
@export var HUD: PlayerHUD


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("dock"):
		DockingTimer.start()
	if Input.is_action_just_released("dock"):
		DockingTimer.stop()


func _physics_process(delta: float) -> void:
	if PlayerManager.is_docked:
		velocity = velocity.move_toward(Vector2.ZERO, delta * FRICTION)
		return
		
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


func _on_area_2d_body_entered(body: Node2D) -> void:
	if not body.is_in_group("ports"):
		return
	PlayerManager.entered_port(body)


func _on_area_2d_body_exited(body: Node2D) -> void:
	if not body.is_in_group("ports"):
		return
	PlayerManager.exited_port()


func _on_docking_timer_timeout() -> void:
	if PlayerManager.in_port or PlayerManager.is_docked:
		if PlayerManager.is_docked:
			HUD.zoom_in()
		else:
			PlayerManager.check_contracts()
			HUD.show_port_title()
			HUD.zoom_out()
			HUD.make_contracts()

		PlayerManager.is_docked = not PlayerManager.is_docked
