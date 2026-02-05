class_name Port extends StaticBody2D

@export var title := ""
@onready var TitleLabel = $Title


func _ready() -> void:
	TitleLabel.text = title
	TitleLabel.rotation = - rotation
	TitleLabel.global_position -= TitleLabel.size * 1.5
