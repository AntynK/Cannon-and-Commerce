extends Menu

@onready var List = %ContractList

func enter() -> void:
	super()
	List.fill_list()
