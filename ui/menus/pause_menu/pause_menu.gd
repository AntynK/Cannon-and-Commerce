extends Menu

signal resume_pressed


func _on_resume_pressed() -> void:
	resume_pressed.emit()


func _on_exit_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://states/main_screen/main_screen.tscn")
