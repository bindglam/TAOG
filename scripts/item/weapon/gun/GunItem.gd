class_name GunItem
extends WeaponItem

@export var ammo: int
@export var max_ammo: int
@export var reload_time: float

@onready var animation_player: AnimationPlayer = $AnimationPlayer

var action_states: Dictionary = { "shooting": false, "reloading": false, "aimming": false }

var on_timeout := func():
	if action_states["shooting"]: action_states["shooting"] = false

func _ready() -> void:
	timer.timeout.connect(on_timeout)

func on_shoot():
	pass
	
func on_reload():
	pass

func on_aim():
	pass

func on_use():	
	if action_states["shooting"]: return
	action_states["shooting"] = true
	
	animation_player.play("fire")
	
	#on_attack(null)
	on_shoot()
