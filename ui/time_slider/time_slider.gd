class_name TimeSlider extends AspectRatioContainer

@onready var SkyBG: TextureRect = %SkyBG
@onready var SkyObject: TextureRect = %SkyObject

@export var Moon: Texture2D
@export var Sun: Texture2D

@onready var max_width := SkyBG.size.x


func _ready() -> void:
	SkyObject.texture = Moon
	SkyObject.position.x = 0


func _process(_delta: float) -> void:
	var day_time := TimeManager.get_day_time()
	var hours := day_time / TimeManager.GAME_HOUR
	SkyObject.position.x = day_time / TimeManager.GAME_DAY * max_width - SkyObject.size.x / 2

	if hours >= TimeManager.DAY_START and hours <= TimeManager.DAY_END:
		SkyObject.texture = Sun
	else:
		SkyObject.texture = Moon
