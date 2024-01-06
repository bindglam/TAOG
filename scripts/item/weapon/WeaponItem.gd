class_name WeaponItem
extends UsableItem

@export var damage: float

func on_attack(_target: Character):
	pass

func on_use():
	on_attack(null)
