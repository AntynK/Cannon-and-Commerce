class_name SoundManger extends Node

@onready var Docking: AudioStreamPlayer = $Docking
@onready var DockedSound: AudioStreamPlayer = $Docked
@onready var ContractCompleted: AudioStreamPlayer = $ContractCompleted


func _ready() -> void:
	EventManager.contracted_completed.connect(func(_a): ContractCompleted.play())

	EventManager.player_docked.connect(docked)
	EventManager.player_undocked.connect(docked)

	EventManager.dock_button_pressed.connect(Docking.play)
	EventManager.dock_button_realesed.connect(Docking.stop)


func docked() -> void:
	Docking.stop()
	DockedSound.pitch_scale = randf_range(0.9, 1.0)
	DockedSound.play()
