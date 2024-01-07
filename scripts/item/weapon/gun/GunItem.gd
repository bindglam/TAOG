class_name GunItem
extends WeaponItem

enum ShootType {
	AUTO,
	SEMI
}

const NORMAL_BULLET_SCENE := preload("res://scenes/bullet/normal_bullet.tscn")

@export var ammo: int
@export var max_ammo: int
@export var reload_time: float
@export var shoot_type: ShootType

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var muzzle_pos: Node2D = $MuzzlePos

var action_states: Dictionary = { "shooting": false, "reloading": false, "aimming": false }
var attacker: Character

var on_timeout := func():
	if action_states["shooting"]: action_states["shooting"] = false

func _ready() -> void:
	super._ready()
	timer.wait_time = 60 / cooldown
	timer.timeout.connect(on_timeout)

func on_shoot():
	pass
	
func on_reload():
	pass

func on_aim():
	pass

func use():
	if timer == null: return
	if not timer.is_stopped(): return
	if action_states["shooting"]: return
	action_states["shooting"] = true
	
	var bullet = NORMAL_BULLET_SCENE.instantiate()
	get_tree().current_scene.get_node("Bullets").add_child.call_deferred(bullet)
	bullet.global_position = muzzle_pos.global_position
	bullet.rotation = attacker.hand.rotation
	bullet.attacker = attacker
	bullet.damage = damage
	
	animation_player.stop()
	animation_player.play("fire")
	
	#on_attack(null)
	on_shoot()
	
	timer.start()
