class_name ContractItem extends PanelContainer

@onready var Source: Label = %Source
@onready var Destination: Label = %Destination
@onready var ExpireDate: Label = %ExpireDate
@onready var Reward: Label = %Reward
@onready var Penalty: Label = %Penalty
@onready var Quantity: Label = %Quantity
@onready var CargoValue: Label = %CargoValue
@onready var Status: Label = %Status
@onready var Buttons: HBoxContainer = %Buttons

signal contract_accepted(index)
signal contract_declined(index)
var _index: int = 0

func setup(contract: ContractManager.Contract, show_buttons: bool, can_be_accepted: bool, index: int) -> void:
	Source.text = "Source: %s" % contract.source
	Destination.text = "Destination: %s" % contract.destination
	ExpireDate.text = "Expire date: %s" % contract.expire_date
	Reward.text = "Reward: %s" % contract.reward
	Penalty.text = "Penalty: %s" % contract.penalty
	Quantity.text = "Quantity: %s" % contract.quantity
	CargoValue.text = "Cargo value: %s" % contract.cargo_value
	Status.text = "Status: %s" % contract.status

	_index = index
	
	if show_buttons:
		Buttons.show()
		for button in Buttons.get_children():
			button.disabled = not can_be_accepted
	else:
		Buttons.hide()


func _on_accept_pressed() -> void:
	contract_accepted.emit(_index)


func _on_decline_pressed() -> void:
	contract_declined.emit(_index)
