extends ConditionLeaf

var detect_enemies: PackedStringArray
var distance_area: Area2D

func tick(_actor: Node, blackboard: Blackboard) -> int:
	var character: Character = _actor as Character
	if character.is_dead: return FAILURE
	if distance_area == null: return RUNNING
	for body in distance_area.get_overlapping_bodies():
		if not body is Character: continue
		if body.is_dead: continue
		if body.name in detect_enemies:
			blackboard.set_value("enemy", body)
			return SUCCESS
	return RUNNING
