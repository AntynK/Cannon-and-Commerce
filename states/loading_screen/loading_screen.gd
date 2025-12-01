extends CanvasLayer

const TARGET_SCENE_PATH := "res://states/sailing/sailing.tscn"
const PHRASES: Array[String] = [
	"Pouring water into the sea...",
	"Cleaning the sand...",
	"Waking up Poseidon...",
	"Taming the Ctulhu...",
	"Sobering the crew...",
	"Inviting the rats onboard..."
]
var progress = []

@onready var Info: Label = %Info
@onready var LoadingStatus: ProgressBar = %LoadingStatus


func _ready() -> void:
	get_tree().paused = true
	ResourceLoader.load_threaded_request(TARGET_SCENE_PATH)
	Info.text = PHRASES.pick_random()


func _process(_delta: float) -> void:
	var status = ResourceLoader.load_threaded_get_status(TARGET_SCENE_PATH, progress)

	LoadingStatus.value = progress[0] * 100
	
	if status == ResourceLoader.THREAD_LOAD_LOADED:
		var scene: PackedScene = ResourceLoader.load_threaded_get(TARGET_SCENE_PATH)
		get_tree().change_scene_to_packed(scene)


func _on_timer_timeout() -> void:
	Info.text = PHRASES.pick_random()
