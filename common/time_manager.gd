extends Node


var game_time := 0.0

const MINUTE := 60
const HOUR := 60
const DAY := 24

const GAME_MINUTE := 0.2 # Treat game minute as real world second
const GAME_HOUR := GAME_MINUTE * 60
const GAME_DAY := GAME_HOUR * 24

const DAY_START := 7
const DAY_END := 17


func _process(delta: float) -> void:
	if not get_tree().paused:
		game_time += delta


func get_day_time() -> float:
	return fmod(game_time, GAME_DAY)


func get_hours() -> int:
	return int(get_day_time() / GAME_HOUR)


func get_mins() -> int:
	return int(fmod(get_day_time(), GAME_HOUR) / GAME_MINUTE)
