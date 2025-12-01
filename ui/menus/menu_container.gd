extends CanvasLayer

enum States {
	NONE,
	PAUSE_MENU,
	SIDE_MENU,
	MAP_MENU
}

var active_state := States.NONE

@onready var PauseMenu: Menu = $PauseMenu
@onready var SideMenu: Menu = $SideMenu
@onready var MapMenu: Menu = $MapMenu
@onready var MENUS: Dictionary = {States.PAUSE_MENU: PauseMenu, States.SIDE_MENU: SideMenu, States.MAP_MENU: MapMenu}


func _ready() -> void:
	for state in MENUS:
		MENUS[state].hide()
	EventManager.side_menu_toggle.connect(func(): toggle_state(States.SIDE_MENU))
	EventManager.map_menu_toggle.connect(func(): toggle_state(States.MAP_MENU))
	EventManager.player_docked.connect(func(): show_state(States.SIDE_MENU))


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("open_pause_menu"):
		if not toggle_state(States.PAUSE_MENU):
			hide_state(active_state)

	if Input.is_action_just_pressed("dock") and PlayerManager.is_docked and active_state != 0 and active_state != States.PAUSE_MENU:
		hide_state(active_state)


func toggle_state(state: States) -> bool:
	if active_state == States.NONE:
		show_state(state)
		return true
	elif active_state == state:
		hide_state(state)
		return true
	return false


func show_state(state: States) -> void:
	get_tree().paused = true
	MENUS[state].enter()
	active_state = state


func hide_state(state: States) -> void:
	get_tree().paused = false
	MENUS[state].exit()
	active_state = States.NONE


func _on_pause_menu_resume_pressed() -> void:
	hide_state(active_state)
