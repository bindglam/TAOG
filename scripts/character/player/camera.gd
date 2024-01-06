extends Camera2D

@export var target: NodePath

func _process(_delta: float) -> void:
	global_position = global_position.lerp((get_node(target) as Node2D).global_position, 0.1)
