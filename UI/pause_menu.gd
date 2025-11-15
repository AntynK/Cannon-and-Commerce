extends CanvasLayer

signal resumed

func _on_resume_button_pressed():
	# Sends signal to the UI manager
	emit_signal("resumed")
	
#func _ready():
	# Connect buttons
	#$VBoxContainer/PauseButton.connect("pressed", _on_resume_button_pressed)
func set_menu_visibility(is_visible: bool):
	if get_child_count() > 0:
		# Target the visible Control node (the main panel/container)
		var visible_panel = get_child(0) 
		visible_panel.visible = is_visible
