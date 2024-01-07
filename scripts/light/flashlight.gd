extends PointLight2D

@export var target: Node2D

func _ready() -> void:
	get_tree().current_scene.get_node("Lights").add_child.call_deferred(self)

func _process(delta: float) -> void:
	global_position = target.global_position
	global_rotation = target.global_rotation
