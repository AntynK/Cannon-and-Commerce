extends Camera2D

const look_ahead_factor := 0.2
const shift_speed := 2.0

@export var map: TileMapLayer
@onready var target: Player = get_parent()


func _ready() -> void:
	var map_rect := map.get_used_rect()
	var tile_size = map.tile_set.tile_size.x
	
	limit_left = map_rect.position.x * tile_size
	limit_top = map_rect.position.y * tile_size
	limit_right = map_rect.end.x * tile_size
	limit_bottom = map_rect.end.y * tile_size


func _process(delta: float) -> void:
	if target.velocity:
		var target_offset = target.velocity * look_ahead_factor
		
		offset = offset.lerp(target_offset, shift_speed * delta)
