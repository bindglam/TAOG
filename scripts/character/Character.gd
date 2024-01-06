class_name Character
extends CharacterBody2D

@export var walk_speed: float = 3000.0
@export var health: float = 100.0
@export var max_health: float = 100.0
@export var item_1: PackedScene
@export var item_2: PackedScene

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite2D
@onready var hand: Node2D = $Hand

var speed: float = walk_speed
var direction: Vector2 = Vector2()
var anim_direction: String = "down"

func movement(delta: float):
	if direction:
		velocity = velocity.lerp(direction * speed * delta, 0.1)
	else:
		velocity = velocity.lerp(Vector2(), 0.1)

func animation():
	if direction.x > 0 and direction.y == 0:
		animation_player.play("walk_" + anim_direction)
		hand.position = Vector2(4, -3)
	elif direction.x < 0 and direction.y == 0:
		animation_player.play("walk_" + anim_direction)
		hand.position = Vector2(-4, -3)
	
	if direction.y < 0:
		animation_player.play("walk_" + anim_direction)
	elif direction.y > 0:
		animation_player.play("walk_" + anim_direction)
	
	if direction.x == 0 and direction.y == 0:
		animation_player.play("idle_" + anim_direction)
		
	if anim_direction == "up" and not sprite.flip_h:
		hand.position = Vector2(-6, -5)
	elif anim_direction == "up" and sprite.flip_h:
		hand.position = Vector2(6, -5)
	elif anim_direction == "down" and not sprite.flip_h:
		hand.position = Vector2(4, -2)
	elif anim_direction == "down" and sprite.flip_h:
		hand.position = Vector2(-4, -2)
	elif anim_direction == "side" and not sprite.flip_h:
		hand.position = Vector2(4, -3)
	elif anim_direction == "side" and sprite.flip_h:
		hand.position = Vector2(-4, -3)

func update_direction():
	var mouse_position = get_global_mouse_position()
	
	hand.rotation = (mouse_position - position).angle()
	
	if hand.rotation_degrees >= 360:
		hand.rotation_degrees = 0
	elif hand.rotation_degrees <= - 360:
		hand.rotation_degrees = 0
	
	var hrotation = int(hand.rotation_degrees)
	
	if hrotation > - 45 and hrotation <= 45:
		anim_direction = "side"
	elif hrotation > 45 and hrotation <= 135:
		anim_direction = "down"
	elif (hrotation > 135 and hrotation <= 180) or (hrotation < - 135 and hrotation >= - 180):
		anim_direction = "side"
	elif hrotation < - 45 and hrotation >= - 135:
		anim_direction = "up"
		
	if (hrotation > 90 and hrotation <= 180) or (hrotation >= - 179 and hrotation < - 90):
		hand.scale.y = hand.scale.x * - 1
		sprite.flip_h = true
	else :
		hand.scale.y = hand.scale.x * 1
		sprite.flip_h = false

func update_hand():
	if item_1 != null and hand.get_child_count() <= 0:
		var item_1_clone = item_1.instantiate()
		hand.add_child.call_deferred(item_1_clone)
	else:
		if hand.get_child_count() >= 1: hand.remove_child(hand.get_child(0))
