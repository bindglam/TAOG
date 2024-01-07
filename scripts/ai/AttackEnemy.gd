extends ActionLeaf

func tick(actor: Node, _blackboard: Blackboard) -> int:
	var character: Character = actor as Character
	character.use_item()
	return SUCCESS

