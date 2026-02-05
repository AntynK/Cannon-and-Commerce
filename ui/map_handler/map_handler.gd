extends Node

@onready var WorldViewport: SubViewport = %SubViewport
@export var Menus: MenuContainer


func _ready() -> void:
	WorldViewport.world_2d = get_viewport().world_2d
	

func _process(_delta: float) -> void:
	Menus.set_map_image(WorldViewport.get_texture())
