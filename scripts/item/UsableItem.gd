class_name UsableItem
extends Item

enum UseSlot {
	HAND_1,
	HAND_2,
	HEAD,
	BODY
}

@export var cooldown: float
@export var use_slot: UseSlot

@onready var timer: Timer = Timer.new()

func _ready() -> void:
	add_child.call_deferred(timer)
	timer.wait_time = cooldown
	timer.one_shot = true
	timer.autostart = false

func on_use():
	pass

func use():
	if not timer.is_stopped(): return
	on_use()
	timer.start()

func input(_type):
	pass
