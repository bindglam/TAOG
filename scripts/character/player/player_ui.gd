extends Control

@onready var blood_overlay: TextureRect = $BloodOverlay
@onready var health_bar: TextureProgressBar = $HealthBar
@onready var health_bar_anim: AnimationPlayer = $HealthBar/AnimationPlayer
@onready var ItemInfoName: Label = $ItemInfo/ItemInfo/Name
@onready var ItemInfoHolder: TextureRect = $ItemInfo/ItemHolder
@onready var ItemInfoInfo: Label = $ItemInfo/ItemInfo/Info
@onready var screen_switcher: ColorRect = $ScreenSwitcher

var health: float = 0.0
var max_health: float = 0.0

func _process(_delta: float) -> void:
	var tween = create_tween()
	tween.tween_property(health_bar, "value", health/max_health*100.0, 0.1)
	
	health_bar_anim.play("idle")
	if health/max_health >= 1.0:
		health_bar_anim.speed_scale = 1.0
	elif health/max_health > 0.0 and health/max_health < 1.0:
		health_bar_anim.speed_scale = 1.0 + (1.0 - health/max_health)
	else:
		health_bar_anim.speed_scale = 0.0
	
	if is_instance_valid(Global.player.selected_item):
		ItemInfoName.text = Global.player.selected_item.name
		
		if ItemInfoHolder.get_child_count() > 0:
			for i in ItemInfoHolder.get_children():
				i.queue_free()
		
		var packed_current_item = PackedScene.new()
		packed_current_item.pack(Global.player.selected_item)
		
		var new_current_item:Node2D = packed_current_item.instantiate()
		ItemInfoHolder.add_child(new_current_item)
		new_current_item.scale = Vector2(4, 4)
		new_current_item.position = Vector2(80, 50)
		
		if Global.player.selected_item is GunItem:
			ItemInfoInfo.text = str(Global.player.selected_item.ammo) + " / " + str(Global.player.selected_item.max_ammo)
		else :
			ItemInfoInfo.text = ""
	else :
		if Global.current_lang == "한국어":
			ItemInfoName.text = "비어 있음"
		else :
			ItemInfoName.text = "Empty"
		ItemInfoInfo.text = ""
		if ItemInfoHolder.get_child_count() > 0:
			for i in ItemInfoHolder.get_children():
				i.queue_free()

func on_damage(_damage, _damager):
	var tween = create_tween()
	tween.tween_property(blood_overlay, "modulate", Color(Color.WHITE, 0.6), 0.1)
	tween.tween_property(blood_overlay, "modulate", Color(Color.WHITE, 0.0), 0.1)

func switch_screen(start, end, duration):
	var tween = create_tween()
	tween.tween_property(screen_switcher, "color", start, duration)
	tween.tween_property(screen_switcher, "color", end, duration)
