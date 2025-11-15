extends Node

const REP_0_DISTANCE_THRESHOLD := 1500
const MAX_CARGO_VALUE := 5
const MAX_CONTRACT_COUNT := 5

class Contract:
	var source := ""
	var destination := ""
	var distance := 0
	var cargo_value := 0
	var penalty := 0.0
	var reward := 0.0


	func _init(source_port: Port, destination_port: Port, value: int) -> void:
		source = source_port.title
		destination = destination_port.title
		distance = int(source_port.global_position.distance_to(destination_port.global_position))
		cargo_value = value
		reward = distance / 100.0 * cargo_value
		penalty = reward + cargo_value * 10


	func can_be_accepted() -> bool:
		return PlayerManager.port.title == source
	

	func _to_string() -> String:
		return "Contract<source_port=%s, destination_port=%s, distance=%s, cargo_value=%s, penalty=%s, reward=%s>" % [source, destination, distance, cargo_value, penalty, reward]


func _generate_contracts_0_rep() -> Array[Contract]:
	var contracts: Array[Contract] = []
	for port in get_tree().get_nodes_in_group("ports"):
		if contracts.size() == MAX_CONTRACT_COUNT:
			break
		if port == PlayerManager.port:
			continue

		if PlayerManager.port.global_position.distance_to(port.global_position) < 2000:
			contracts.append(Contract.new(PlayerManager.port, port, 1))
			
	contracts.shuffle()
	return contracts


func _generate_contracts_normal_rep() -> Array[Contract]:
	var contracts: Array[Contract] = []
	var ports = get_tree().get_nodes_in_group("ports")
	for port in ports.duplicate():
		if contracts.size() == MAX_CONTRACT_COUNT:
			break

		if randf() < 0.4:
			ports.erase(port)
			var new_source = ports.pick_random()
			contracts.append(Contract.new(new_source, port, randi_range(1, MAX_CARGO_VALUE)))
		elif port != PlayerManager.port:
			contracts.append(Contract.new(PlayerManager.port, port, randi_range(1, MAX_CARGO_VALUE)))
		
	contracts.shuffle()
	return contracts


func generate_contracts() -> Array[Contract]:
	if PlayerManager.reputation == 0:
		return _generate_contracts_0_rep()
	return _generate_contracts_normal_rep()
