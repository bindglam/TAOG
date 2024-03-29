extends Panel
	
@onready var slots = get_children()
var items = {}
	
func _ready():
	for slot in slots:
		items[slot.name] = null
		
func _process(_delta:float)->void :
	var player: Character = get_parent().get_parent().get_parent().get_parent().get_parent()
	if items["HAND_1"] == null:
		player.primary_item = null
	else:
		items["HAND_1"].set_meta("item_data", player.primary_item)
	if items["HAND_2"] == null:
		player.secondary_item = null
	else:
		items["HAND_2"].set_meta("item_data", player.secondary_item)
	
func insert_item(item):
	var item_pos = item.global_position + item.size / 2
	var slot = get_slot_under_pos(item_pos)
	if slot == null:
		return false
	
	var item_slot
	if not ItemDB.get_item(item.get_meta("item_name")).instantiate() is UsableItem:
		return false
	else:
		item_slot = ItemDB.get_item(item.get_meta("item_name")).instantiate().use_slot
		if item_slot == 0: item_slot = "HAND_1"
		elif item_slot == 1: item_slot = "HAND_2"
		elif item_slot == 2: item_slot = "HEAD"
		elif item_slot == 3: item_slot = "BODY"
	if item_slot != slot.name:
		return false
	if items[item_slot] != null:
		return false
	items[item_slot] = item
	if item_slot == "HAND_1" and item.has_meta("item_data"):
		var packed_item = item.get_meta("item_data")
		get_parent().get_parent().get_parent().get_parent().get_parent().primary_item = packed_item
	if item_slot == "HAND_2" and item.has_meta("item_data"):
		var packed_item = item.get_meta("item_data")
		get_parent().get_parent().get_parent().get_parent().get_parent().secondary_item = packed_item
	item.global_position = slot.global_position + slot.size / 2 - item.size / 2
	return true
	
func grab_item(pos):
	var item = get_item_under_pos(pos)
	if item == null:
		return null
	
	var player: Character = get_parent().get_parent().get_parent().get_parent().get_parent()
	var item_data = item.get_meta("item_data").instantiate()
	if item_data is UsableItem:
		if player.selected_item != null:
			if item_data.name == player.selected_item.name:
				if not player.selected_item.timer.is_stopped(): return null
	
	var item_slot = ItemDB.get_item(item.get_meta("item_name")).instantiate().use_slot
	if item_slot == 0: item_slot = "HAND_1"
	elif item_slot == 1: item_slot = "HAND_2"
	elif item_slot == 2: item_slot = "HEAD"
	elif item_slot == 3: item_slot = "BODY"
	items[item_slot] = null
	return item
	
func get_slot_under_pos(pos):
	return get_thing_under_pos(slots, pos)
	
func get_item_under_pos(pos):
	return get_thing_under_pos(items.values(), pos)
	
func get_thing_under_pos(arr, pos):
	for thing in arr:
		if thing != null and thing.get_global_rect().has_point(pos):
			return thing
	return null
