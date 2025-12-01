extends Node

const MAX_CARGO_LOAD := 25

var reputation := 0
var balance := 0.0
var loaded_cargo := 0
var in_port := false
var is_docked := false
var port: Port
var player_position: Vector2
var player_rotation: float
var Map: TileMapLayer


func _ready() -> void:
	EventManager.player_entered_port.connect(entered_port)
	EventManager.player_left_port.connect(left_port)
	EventManager.contracted_completed.connect(contract_completed)
	

func entered_port(port_: Port) -> void:
	in_port = true
	port = port_


func left_port(_port) -> void:
	in_port = false


func can_load_cargo(cargo_load: int) -> bool:
	return (PlayerManager.loaded_cargo + cargo_load) <= MAX_CARGO_LOAD
	

func can_be_accepted(contract: ContractManager.Contract) -> bool:
	return PlayerManager.port.title == contract.source and can_load_cargo(contract.quantity) and not ContractManager.has_accepted_contract(contract)


func accept_contract(contract: ContractManager.Contract) -> void:
	if can_be_accepted(contract) and not ContractManager.has_accepted_contract(contract):
		contract.status = ContractManager.ContractStatus.ACCEPTED
		loaded_cargo += contract.quantity


func contract_completed(contract: ContractManager.Contract) -> void:
	reputation += int(contract.reward / 10)
	balance += contract.reward
	loaded_cargo -= contract.quantity
