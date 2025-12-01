extends CanvasLayer

func _ready() -> void:
	get_tree().paused = true


func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://states/loading_screen/loading_screen.tscn")


func _on_exit_button_pressed() -> void:
	get_tree().quit()
