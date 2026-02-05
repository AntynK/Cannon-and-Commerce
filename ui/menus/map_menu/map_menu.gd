extends Menu

@onready var Map: TextureRect = %Map
@onready var PlayerIndexer: TextureRect = %Indexer


func enter():
	super ()
	var game_world_rect := PlayerManager.Map.get_used_rect()
	var tile_size := PlayerManager.Map.tile_set.tile_size
	var map_texture_size = Map.texture.get_size()

	var world_start := game_world_rect.position * tile_size
	var world_size := game_world_rect.size * tile_size
	var player_pos := PlayerManager.player_position - Vector2(world_start)

	var ratio := Vector2(map_texture_size.x / world_size.x, map_texture_size.y / world_size.y)
	PlayerIndexer.position = player_pos * ratio
	PlayerIndexer.rotation = PlayerManager.player_rotation - deg_to_rad(-90)


func set_map_image(img: ViewportTexture) -> void:
	Map.texture = img
