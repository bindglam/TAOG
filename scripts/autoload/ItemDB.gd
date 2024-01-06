extends Node

const ITEMS := { 
	"YH-001": preload("res://scenes/item/weapon/gun/YH-001.tscn"), 
	"error": preload("res://scenes/item/error.tscn"),
}

func get_item(item_id):
	if item_id in ITEMS:
		return ITEMS[item_id]
	else :
		return ITEMS["error"]
