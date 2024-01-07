extends Camera2D

@export var target: NodePath
@export var default_follow_mouse_mul = 0.07
@export var dead_zone = 70
@export var follow_mouse_mul = 0.07

var is_shaking = false
var shake_amount = 0
var default_offset = offset
@onready var timer = $Timer

func _ready() -> void:
	timer.timeout.connect(_on_Timer_timeout)

func _process(_delta:float)->void :
	var _target = get_viewport().get_mouse_position() - get_viewport().size * 0.5
	if _target.length() < dead_zone:
		self.offset = Vector2.ZERO
	else :
		self.offset = _target.normalized() * (_target.length() - dead_zone) * follow_mouse_mul
	
	if is_shaking:
		offset += Vector2(randf_range( - 1, 1) * shake_amount, randf_range( - 1, 1) * shake_amount)
	global_position = global_position.lerp((get_node(target) as Node2D).global_position, 0.1)
	#self.position = lerp(self.position, target_node.position, lerpspeed)
	
func shake(time, amount):
	timer.wait_time = time
	shake_amount = amount
	is_shaking = true
	timer.start()

func _on_Timer_timeout():
	is_shaking = false
