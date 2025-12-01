class_name PlayerHUD extends CanvasLayer

@export var Camera: Camera2D

@onready var PortTitle: Label = %PortTitle
@onready var Balance: Label = %Balance
@onready var Reputation: Label = %Reputation
@onready var TimeLabel: Label = %Time
@onready var DokingProgress: TextureProgressBar = %DokingProgress
@onready var Dock: MarginContainer = %Dock
@onready var DockButton: Button = %DockButton


func _ready() -> void:
	PortTitle.hide()
	Dock.hide()
	DokingProgress.hide()
	
	update_player_stats()
	
	EventManager.player_docked.connect(on_docked)
	EventManager.player_undocked.connect(on_undocked)

	EventManager.player_entered_port.connect(func(_a): Dock.show())
	EventManager.player_left_port.connect(func(_a): Dock.hide())
	EventManager.docking_progress.connect(dock)

	EventManager.dock_button_pressed.connect(dock_button_pressed)
	EventManager.dock_button_realesed.connect(dock_button_realesed)


func dock(progress: float) -> void:
	DokingProgress.value = progress
	if progress >= 90:
		DokingProgress.hide()

	
func _process(_delta: float) -> void:
	TimeLabel.text = "%s:%s" % [str(TimeManager.get_hours()).pad_zeros(2), str(TimeManager.get_mins()).pad_zeros(2)]


func on_docked() -> void:
	show_port_title()
	zoom_out()
	update_player_stats()
	DockButton.text = "Undock"


func on_undocked() -> void:
	zoom_in()
	DockButton.text = "Dock"


func update_player_stats() -> void:
	Balance.text = "$$$: %s" % str(PlayerManager.balance).pad_decimals(2)
	Reputation.text = "Rep: %s" % str(PlayerManager.reputation)


func show_port_title() -> void:
	PortTitle.visible = true
	PortTitle.text = PlayerManager.port.title
	var tween := Camera.create_tween()
	tween.tween_property(PortTitle, "modulate", Color(1, 1, 1, 1), 0.5)
	tween.tween_interval(1)
	tween.tween_property(PortTitle, "modulate", Color(1, 1, 1, 0), 1)
	tween.tween_callback(func(): PortTitle.visible = false)
	
	
func zoom_out() -> void:
	make_transition(Camera, "zoom", Vector2(0.5, 0.5), 1)


func zoom_in() -> void:
	make_transition(Camera, "zoom", Vector2(1, 1), 1)


func make_transition(obj, property: String, final_value, duration: float) -> void:
	var tween := Camera.create_tween()
	tween.tween_property(obj, property, final_value, duration)


func _on_map_pressed() -> void:
	EventManager.map_menu_toggle.emit()


func _on_contracts_pressed() -> void:
	EventManager.side_menu_toggle.emit()


func dock_button_pressed() -> void:
	DokingProgress.show()


func dock_button_realesed() -> void:
	DokingProgress.hide()
