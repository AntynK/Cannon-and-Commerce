extends Node

@onready var Map: TileMapLayer = $TileMap/Ocean


func _ready() -> void:
	get_tree().paused = false
	PlayerManager.Map = Map
	TimeManager.game_time = 0

	var main_viewport = get_viewport()
	main_viewport.canvas_cull_mask = 3
