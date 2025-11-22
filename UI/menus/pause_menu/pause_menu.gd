extends Menu

signal resume_pressed

func _on_resume_pressed() -> void:
	resume_pressed.emit()
