extends Menu

@onready var Map: TextureRect = $Map

func set_map_image(img: ViewportTexture) -> void:
	Map.texture = img
