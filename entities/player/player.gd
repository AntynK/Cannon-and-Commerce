class_name Player extends CharacterBody2D

const ACCELERATION_RATE := 47
const ROTATION_RATE := 55
const FRICTION := 20
const MAX_VELOCITY := 170


@onready var DockingTimer: Timer = $DockingTimer


func _ready() -> void:
	PlayerManager.player_position = global_position
	PlayerManager.player_rotation = rotation


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("dock") and PlayerManager.in_port:
		DockingTimer.start()
		EventManager.dock_button_pressed.emit()

	if Input.is_action_just_released("dock"):
		DockingTimer.stop()
		EventManager.dock_button_realesed.emit()

	if not DockingTimer.is_stopped():
		EventManager.docking_progress.emit((DockingTimer.wait_time - DockingTimer.time_left) / DockingTimer.wait_time * 100)


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
	PlayerManager.player_position = global_position
	PlayerManager.player_rotation = rotation


func get_direction() -> Vector2:
	return Vector2(cos(rotation), sin(rotation))


func _on_area_2d_body_entered(body: Node2D) -> void:
	if not body.is_in_group("ports"):
		return
	EventManager.player_entered_port.emit(body)


func _on_area_2d_body_exited(body: Node2D) -> void:
	if not body.is_in_group("ports"):
		return
	EventManager.player_left_port.emit(body)


func _on_docking_timer_timeout() -> void:
	if PlayerManager.in_port or PlayerManager.is_docked:
		PlayerManager.is_docked = not PlayerManager.is_docked
		if PlayerManager.is_docked:
			EventManager.player_docked.emit()
		else:
			EventManager.player_undocked.emit()
