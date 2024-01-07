extends Character

@export var target: Node2D

@onready var nav_agent: NavigationAgent2D = $NavigationAgent2D

func movement(delta: float):
	direction = to_local(nav_agent.get_next_path_position()).normalized()
	super.movement(delta)

func make_path():
	if target != null: nav_agent.target_position = target.global_position

func _physics_process(delta: float) -> void:
	movement(delta)
	animation()
	if target != null: update_direction(target.global_position)
	update_hand(false)
	
	move_and_slide()
