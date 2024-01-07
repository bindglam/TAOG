extends ActionLeaf

func tick(actor: Node, blackboard: Blackboard) -> int:
	var character: Character = actor as Character
	character.target = blackboard.get_value("enemy")
	character.make_path()
	return FAILURE

