extends Node

@onready var WorldViewport: SubViewport = %SubViewport
@export var Menus: MenuContainer


func _ready() -> void:
	WorldViewport.world_2d = get_viewport().world_2d
	EventManager.map_menu_toggle.connect(render)


func _process(_delta: float) -> void:
	Menus.set_map_image(WorldViewport.get_texture())
	WorldViewport.render_target_update_mode = SubViewport.UPDATE_ONCE
	WorldViewport.render_target_clear_mode = SubViewport.CLEAR_MODE_NEVER


func render() -> void:
	WorldViewport.render_target_update_mode = SubViewport.UPDATE_ALWAYS
	WorldViewport.render_target_clear_mode = SubViewport.CLEAR_MODE_ALWAYS
