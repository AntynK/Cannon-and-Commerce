class_name ContractList extends Control

@onready var ContractItemScene := preload("res://ui/contracts_list/contract_item/contract_item.tscn")
@onready var List: VBoxContainer = %List


func fill_list() -> void:
	for child in List.get_children():
		child.queue_free()

	for index in ContractManager.get_contracts_count():
		var child: ContractItem = ContractItemScene.instantiate()
		List.add_child(child)

		var current_contract := ContractManager.get_contract_at(index)
		var can_be_accepted := PlayerManager.can_be_accepted(current_contract)
		child.setup(current_contract, PlayerManager.is_docked, can_be_accepted, index)

		child.contract_accepted.connect(contract_accepted)
		child.contract_declined.connect(contract_declined)


func contract_accepted(index: int) -> void:
	PlayerManager.accept_contract(ContractManager.get_contract_at(index))
	fill_list()
	

func contract_declined(index: int) -> void:
	ContractManager.remove_contract_at(index)
	fill_list()
