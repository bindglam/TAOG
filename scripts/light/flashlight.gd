extends PointLight2D

@export var target: Node2D = get_parent()

func _process(delta: float) -> void:
	if target == null: return
	global_position = target.global_position
	global_rotation = target.global_rotation

func _input(event: InputEvent) -> void:
	if target.get_parent() is Player:
		if event.is_action_pressed("toggle_flashlight") and not target.get_parent().is_dead:
			enabled = !enabled
