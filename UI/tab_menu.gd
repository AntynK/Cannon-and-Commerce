extends CanvasLayer

signal resumed

#func _input(event):
	#if event.is_action_pressed("open_pause"):
		#emit_signal("resumed")
		#get_tree().root.set_input_as_handled()
		
func set_menu_visibility(is_visible: bool):
	if get_child_count() > 0:
		# Target the visible Control node (the main panel/container)
		var visible_panel = get_child(0) 
		visible_panel.visible = is_visible
