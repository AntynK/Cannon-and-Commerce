extends CanvasModulate


@export var day_night_gradient: Gradient


func _process(_delta: float) -> void:
	var day_progress = TimeManager.get_day_time() / TimeManager.GAME_DAY
	
	color = day_night_gradient.sample(day_progress)
