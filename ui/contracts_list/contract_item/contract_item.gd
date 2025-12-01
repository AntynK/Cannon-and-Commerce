class_name ContractItem extends PanelContainer

signal contract_accepted(index)
signal contract_declined(index)

var _index: int = 0

@onready var Source: Label = %Source
@onready var Destination: Label = %Destination
@onready var ExpireDate: Label = %ExpireDate
@onready var Reward: Label = %Reward
@onready var Penalty: Label = %Penalty
@onready var Quantity: Label = %Quantity
@onready var CargoValue: Label = %CargoValue
@onready var Status: Label = %Status
@onready var Buttons: HBoxContainer = %Buttons


func setup(contract: ContractManager.Contract, show_buttons: bool, can_be_accepted: bool, index: int) -> void:
	Source.text = "Source: %s" % contract.source
	Destination.text = "Destination: %s" % contract.destination
	ExpireDate.text = "Expire date: %s" % contract.expire_date
	Reward.text = "Reward: %s" % contract.reward
	Penalty.text = "Penalty: %s" % contract.penalty
	Quantity.text = "Quantity: %s" % contract.quantity
	CargoValue.text = "Cargo value: %s" % contract.cargo_value
	Status.text = "Status: %s" % translate_status(contract.status)

	if contract.status == ContractManager.ContractStatus.COMPLETED:
		cross_labels()
		show_buttons = false
	_index = index
	
	if show_buttons:
		Buttons.show()
		for button in Buttons.get_children():
			button.disabled = not can_be_accepted
	else:
		Buttons.hide()

func cross_labels() -> void:
	var labels: Array[Label] = [Source, Destination, ExpireDate, Reward, Penalty, Quantity, CargoValue, Status]
	for label in labels:
		var line = ColorRect.new()
		line.name = "StrikeLine"
		line.color = Color.BLACK
		line.mouse_filter = Control.MOUSE_FILTER_IGNORE
		label.add_child(line)
		line.layout_mode = 1
		line.anchors_preset = Control.PRESET_CENTER_LEFT
		line.position.x = 0
		line.position.y = label.size.y / 2
		line.size.y = 2
		line.size.x = 0

		var font = label.get_theme_font("font")
		var font_size = label.get_theme_font_size("font_size")
		var text_width = font.get_string_size(label.text, HORIZONTAL_ALIGNMENT_LEFT, -1, font_size).x

		label.modulate = Color(0.7, 0.7, 0.7)
		line.visible = true
		var tween = create_tween()
		tween.tween_property(line, "size:x", text_width, 0.5)

	
func translate_status(status: ContractManager.ContractStatus) -> String:
	match status:
		ContractManager.ContractStatus.AVAILABLE:
			return "Available"
		ContractManager.ContractStatus.COMPLETED:
			return "Completed"
		ContractManager.ContractStatus.ACCEPTED:
			return "Accepted"
		ContractManager.ContractStatus.FAILED:
			return "Failed"
		_:
			return "Unknown"


func _on_accept_pressed() -> void:
	contract_accepted.emit(_index)


func _on_decline_pressed() -> void:
	contract_declined.emit(_index)
