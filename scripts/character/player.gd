extends Character
class_name Player

@onready var camera: Camera2D = $Camera2D

@onready var player_ui: Control = $Camera2D/CanvasLayer/PlayerUI
@onready var inventory: Control = $Camera2D/CanvasLayer/PlayerUI/Inventory

func _init() -> void:
	Global.player = self

func movement(delta: float):
	if not inventory.visible: direction = Vector2(Input.get_axis("left", "right"), Input.get_axis("forward", "backward"))
	super.movement(delta)

func _physics_process(delta: float) -> void:
	movement(delta)
	animation()
	if not inventory.visible:
		update_direction(get_global_mouse_position())
	update_hand(false)

	move_and_slide()

func _process(_delta: float) -> void:
	if selected_item != null and not inventory.visible:
		if Input.is_action_just_pressed("use") and not selected_item is GunItem:
			use_item()
		elif Input.is_action_just_pressed("use") and selected_item.shoot_type == 1:
			use_item()
		elif Input.is_action_pressed("use") and selected_item.shoot_type == 0:
			use_item()
	
	player_ui.health = health
	player_ui.max_health = max_health

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("inv_toggle"):
		inventory.visible = not inventory.visible
	
	if event.is_action_pressed("select_primary") and not inventory.visible:
		selected_hand = "primary"
		update_hand(true)
	elif event.is_action_pressed("select_secondary") and not inventory.visible:
		selected_hand = "secondary"
		update_hand(true)
	
	if event.is_action_pressed("reload"):
		input_item("reload")

func on_damage(damage, damager):
	super.on_damage(damage, damager)
	
	player_ui.on_damage(damage, damager)
