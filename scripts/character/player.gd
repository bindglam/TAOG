extends Character

@onready var camera: Camera2D = $Camera2D

@onready var player_ui: Control = $Camera2D/CanvasLayer/PlayerUI
@onready var inventory: Control = $Camera2D/CanvasLayer/PlayerUI/Inventory

func _init() -> void:
	Global.player = self

func movement(delta: float):
	direction = Vector2(Input.get_axis("left", "right"), Input.get_axis("forward", "backward"))
	super.movement(delta)

func _physics_process(delta: float) -> void:
	movement(delta)
	animation()
	update_direction()
	update_hand()

	move_and_slide()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("inv_toggle"):
		inventory.visible = not inventory.visible
