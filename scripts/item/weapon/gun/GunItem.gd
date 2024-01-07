class_name GunItem
extends WeaponItem

enum ShootType {
	AUTO,
	SEMI
}

const NORMAL_BULLET_SCENE := preload("res://scenes/bullet/normal_bullet.tscn")
const MUZZLE_EFFECT_SCENE := preload("res://scenes/effect/muzzle_effect.tscn")

@export var ammo: int
@export var max_ammo: int
@export var reload_time: float
@export var shoot_type: ShootType
@export var camera_shake_amount: float

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var muzzle_pos: Node2D = $MuzzlePos
@onready var muzzle_sound: AudioStreamPlayer2D = $MuzzlePos/MuzzleSound
@onready var reload_sound: AudioStreamPlayer2D = $ReloadSound

var action_states: Dictionary = { "shooting": false, "reloading": false, "aimming": false }
var attacker: Character

var on_timeout := func():
	if action_states["shooting"]: action_states["shooting"] = false
	elif action_states["reloading"]:
		action_states["reloading"] = false
		ammo = max_ammo
		timer.wait_time = 60 / cooldown

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
	if action_states["shooting"] or action_states["reloading"]: return
	if ammo <= 0: return
	action_states["shooting"] = true
	
	var bullet = NORMAL_BULLET_SCENE.instantiate()
	get_tree().current_scene.get_node("Bullets").add_child.call_deferred(bullet)
	bullet.global_position = muzzle_pos.global_position
	bullet.rotation = muzzle_pos.global_rotation
	bullet.attacker = attacker
	bullet.damage = damage
	
	animation_player.stop()
	animation_player.play("fire")
	muzzle_sound.play()
	
	var muzzle_effect := MUZZLE_EFFECT_SCENE.instantiate()
	muzzle_pos.add_child.call_deferred(muzzle_effect)
	muzzle_effect.get_node("AnimatedSprite2D").play("default")
	
	if attacker is Player:
		attacker.camera.shake(0.05, camera_shake_amount)
	
	#on_attack(null)
	on_shoot()
	
	timer.start()
	ammo -= 1

func input(type):
	if type == "reload":
		if timer == null: return
		if not timer.is_stopped(): return
		if action_states["shooting"] or action_states["reloading"]: return
		if ammo == max_ammo: return
		action_states["reloading"] = true
		
		ammo = 0
		
		animation_player.stop()
		animation_player.play("reload")
		reload_sound.play()
		
		timer.wait_time = reload_time
		timer.start()
