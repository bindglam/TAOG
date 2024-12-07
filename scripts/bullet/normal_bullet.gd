extends CharacterBody2D

@export var speed: float = 5000
@onready var area2d: Area2D = $Area2D
@onready var timer: Timer = $Timer
var damage = 0
var head_damage = 0
var attacker = null

var _on_Area2D_body_entered = func(body):
	if body == self or body == attacker: return
	if body.has_method("on_damage"):
		body.on_damage(damage, attacker)
	queue_free()

var _on_time_out = func():
	queue_free()

func _ready() -> void:
	area2d.body_entered.connect(_on_Area2D_body_entered)
	timer.timeout.connect(_on_time_out)

func _physics_process(delta):
	var _collision_info = move_and_collide(transform.x * delta * speed)
