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
	update_direction(get_global_mouse_position())
	update_hand(false)

	move_and_slide()

func _process(_delta: float) -> void:
	if selected_item != null:
		if Input.is_action_just_pressed("use") and not selected_item is GunItem:
			use_item()
		elif Input.is_action_just_pressed("use") and selected_item.shoot_type == 1:
			use_item()
		elif Input.is_action_pressed("use") and selected_item.shoot_type == 0:
			use_item()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("inv_toggle"):
		inventory.visible = not inventory.visible
	
	if event.is_action_pressed("select_primary"):
		selected_hand = "primary"
		update_hand(true)
	elif event.is_action_pressed("select_secondary"):
		selected_hand = "secondary"
		update_hand(true)
