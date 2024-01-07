extends ActionLeaf

func tick(actor: Node, _blackboard: Blackboard) -> int:
	var character: Character = actor as Character
	if character.primary_item == null: return FAILURE
	character.use_item()
	
	if character.selected_item is GunItem:
		if character.selected_item.ammo == 0: character.input_item("reload")
	return SUCCESS

