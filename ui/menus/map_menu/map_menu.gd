extends Menu

@onready var Map: TextureRect = %Map
@onready var PlayerIndexer: TextureRect = %Indexer


func enter():
	super ()
	var map_rect := PlayerManager.Map.get_used_rect()
	var tile_size := PlayerManager.Map.tile_set.tile_size.x
	
	var world_start := map_rect.position * tile_size
	var world_size := map_rect.size * tile_size
	var player_pos := PlayerManager.player_position - Vector2(world_start)

	var ratio = Vector2(player_pos.x / world_size.x, player_pos.y / world_size.y) - Vector2(0.09, 0.08)

	PlayerIndexer.position = Map.texture.get_size() * ratio
	PlayerIndexer.rotation = PlayerManager.player_rotation - deg_to_rad(-90)
