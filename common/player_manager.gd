extends Node

var reputation := 0
var balance := 0
var cargo_capacity := 25
var contracts: Array[ContractManager.Contract] = []
var in_port := false
var is_docked := false
var port: Port

func entered_port(port_: Port) -> void:
    in_port = true
    port = port_


func exited_port() -> void:
    in_port = false