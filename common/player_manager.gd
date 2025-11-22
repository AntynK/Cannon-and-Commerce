extends Node

const MAX_CARGO_LOAD := 25

var reputation := 0
var balance := 0.0
var loaded_cargo := 0
var accepted_contracts: Array[ContractManager.Contract] = []
var in_port := false
var is_docked := false
var port: Port


func entered_port(port_: Port) -> void:
	in_port = true
	port = port_


func exited_port() -> void:
	in_port = false


func can_load_cargo(cargo_load: int) -> bool:
	return (PlayerManager.loaded_cargo + cargo_load) <= MAX_CARGO_LOAD
	

func can_be_accepted(contract: ContractManager.Contract) -> bool:
	return PlayerManager.port.title == contract.source and can_load_cargo(contract.quantity) and not accepted_contracts.has(contract)


func accept_contract(contract: ContractManager.Contract) -> void:
	if can_be_accepted(contract) and not accepted_contracts.has(contract):
		contract.status = ContractManager.ContractStatus.ACCEPTED
		accepted_contracts.append(contract)
		loaded_cargo += contract.quantity


func contract_completed(contract: ContractManager.Contract) -> void:
	reputation += int(contract.reward / 10)
	balance += contract.reward
	loaded_cargo -= contract.quantity
	accepted_contracts.erase(contract)
	ContractManager.active_contracts.erase(contract)


func check_contracts() -> void:
	if accepted_contracts.size() == 0:
		return
	for contract in accepted_contracts.duplicate():
		if contract.destination == port.title:
			contract_completed(contract)
