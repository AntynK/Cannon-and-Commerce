class_name PlayerHUD extends CanvasLayer

@export var Camera: Camera2D

@onready var PortTitle: Label = %PortTitle
@onready var Balance: Label = %Balance
@onready var Reputation: Label = %Reputation

func _ready() -> void:
	PortTitle.visible = false
	update_player_stats()


func on_docked() -> void:
	show_port_title()
	zoom_out()
	update_player_stats()


func update_player_stats() -> void:
	Balance.text = "$$$: %s" % str(PlayerManager.balance).pad_decimals(2)
	Reputation.text = "Rep: %s" % str(PlayerManager.reputation)


func show_port_title() -> void:
	PortTitle.visible = true
	PortTitle.text = PlayerManager.port.title
	var tween := Camera.create_tween()
	tween.tween_property(PortTitle, "modulate", Color(1, 1, 1, 1), 0.5)
	tween.tween_interval(3)
	tween.tween_property(PortTitle, "modulate", Color(1, 1, 1, 0), 1)
	tween.tween_callback(func(): PortTitle.visible = false)
	
	
func zoom_out() -> void:
	make_transition(Camera, "zoom", Vector2(0.5, 0.5), 1)


func zoom_in() -> void:
	make_transition(Camera, "zoom", Vector2(1, 1), 1)


func make_transition(obj, property: String, final_value, duration: float) -> void:
	var tween := Camera.create_tween()
	tween.tween_property(obj, property, final_value, duration)
