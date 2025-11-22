extends Node

const REP_0_DISTANCE_THRESHOLD := 2000
const MAX_CARGO_VALUE := 5
const MAX_CONTRACT_COUNT := 5

var active_contracts: Array[Contract] = []

enum ContractStatus {
	ACCEPTED,
	FAILED,
	AVAILABLE
}

class Contract:
	var source := ""
	var destination := ""
	var distance := 0
	var cargo_value := 0
	var quantity := 0
	var penalty := 0.0
	var reward := 0.0
	var expire_date := 0
	var status := ContractStatus.AVAILABLE

	func _init(source_port: Port, destination_port: Port, value: int) -> void:
		source = source_port.title
		destination = destination_port.title
		distance = int(source_port.global_position.distance_to(destination_port.global_position))
		cargo_value = value
		reward = distance / 10.0 * cargo_value
		penalty = reward / 10 + cargo_value
		quantity = cargo_value * 4

	func _to_string() -> String:
		return "Contract<source_port=%s, destination_port=%s, distance=%s, cargo_value=%s, penalty=%s, reward=%s>" % [source, destination, distance, cargo_value, penalty, reward]


func _generate_contracts_0_rep(max_contract_count: int) -> Array[Contract]:
	var contracts: Array[Contract] = []
	for port in get_tree().get_nodes_in_group("ports"):
		if contracts.size() == max_contract_count:
			break
		if port == PlayerManager.port:
			continue

		if PlayerManager.port.global_position.distance_to(port.global_position) < REP_0_DISTANCE_THRESHOLD:
			contracts.append(Contract.new(PlayerManager.port, port, 1))

	contracts.shuffle()
	return contracts


func _generate_contracts_normal_rep(max_contract_count: int) -> Array[Contract]:
	var contracts: Array[Contract] = []
	var ports = get_tree().get_nodes_in_group("ports")
	for port in ports.duplicate():
		if contracts.size() == max_contract_count:
			break

		if randf() < 0.4:
			ports.erase(port)
			var new_source = ports.pick_random()
			contracts.append(Contract.new(new_source, port, randi_range(1, MAX_CARGO_VALUE)))
		elif port != PlayerManager.port:
			contracts.append(Contract.new(PlayerManager.port, port, randi_range(1, MAX_CARGO_VALUE)))
	
	contracts.shuffle()
	return contracts


func generate_contracts(max_contract_count: int) -> Array[Contract]:
	if not PlayerManager.is_docked or max_contract_count <= 0:
		return []

	if PlayerManager.reputation <= 0:
		return _generate_contracts_0_rep(max_contract_count)
	return _generate_contracts_normal_rep(max_contract_count)


func fill_contracts() -> void:
	if get_contracts_count() != MAX_CONTRACT_COUNT:
		append_contracts(ContractManager.generate_contracts(MAX_CONTRACT_COUNT - get_contracts_count()))
		active_contracts.sort_custom(func(a, _b): return PlayerManager.can_be_accepted(a))


func append_contracts(new_contracts: Array[ContractManager.Contract]) -> void:
	for new_contract in new_contracts:
		var success = true
		for contract in active_contracts:
			if new_contract.distance == contract.distance:
				success = false
				continue
		if success:
			active_contracts.append(new_contract)

func get_contract_at(index: int) -> Contract:
	return active_contracts[index]

func get_contracts_count() -> int:
	return active_contracts.size()

func remove_contract_at(index: int) -> void:
	active_contracts.remove_at(index)