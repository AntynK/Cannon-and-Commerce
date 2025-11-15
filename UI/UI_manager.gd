extends Node

enum UI_states {
	GAMEPLAY,
	FUNC_MENU,
	PAUSE_MENU
}

var current_state = UI_states.GAMEPLAY

const FUNC_MENU_SCENE = preload("res://UI/game_menu.tscn")
const PAUSE_MENU_SCENE = preload("res://UI/pause_menu.tscn")

var func_menu_instance
var pause_menu_instance
		
func _ready():
	func_menu_instance = FUNC_MENU_SCENE.instantiate()
	pause_menu_instance = PAUSE_MENU_SCENE.instantiate()
	process_mode = Node.PROCESS_MODE_ALWAYS
	
	
	func_menu_instance.set_menu_visibility(false)
	pause_menu_instance.set_menu_visibility(false)
	
	func_menu_instance.connect("resumed", _on_menu_resumed)
	pause_menu_instance.connect("resumed", _on_menu_resumed)
	
	get_tree().root.add_child.call_deferred(func_menu_instance)
	get_tree().root.add_child.call_deferred(pause_menu_instance)
	
func change_state(new_state):
	get_tree().paused = false
	
	func_menu_instance.set_menu_visibility(false)
	pause_menu_instance.set_menu_visibility(false)
	
	match new_state:
		UI_states.GAMEPLAY:
			pass
			
		UI_states.FUNC_MENU:
			get_tree().paused = true
			func_menu_instance.set_menu_visibility(true)
			
		UI_states.PAUSE_MENU:
			get_tree().paused = true
			pause_menu_instance.set_menu_visibility(true)
	current_state = new_state
			
func _on_menu_resumed():
	if current_state != UI_states.GAMEPLAY:
		change_state(UI_states.GAMEPLAY)

func _unhandled_input(event):
	match current_state:
		
		UI_states.GAMEPLAY:
			if event.is_action_pressed("open_tabs"):
				change_state(UI_states.FUNC_MENU)
				get_tree().root.set_input_as_handled()
				
			elif event.is_action_pressed("open_pause"):
				change_state(UI_states.PAUSE_MENU)
				get_tree().root.set_input_as_handled()
				
		UI_states.FUNC_MENU:
			if event.is_action_pressed("open_tabs"):
				change_state(UI_states.GAMEPLAY)
				get_tree().root.set_input_as_handled()
				
			elif event.is_action_pressed("open_pause"):
				change_state(UI_states.PAUSE_MENU)
				get_tree().root.set_input_as_handled()
				
		UI_states.PAUSE_MENU:
			if event.is_action_pressed("open_pause"):
				change_state(UI_states.GAMEPLAY)
				get_tree().root.set_input_as_handled()
