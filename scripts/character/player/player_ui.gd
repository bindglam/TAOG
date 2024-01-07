extends Control

@onready var blood_overlay: TextureRect = $BloodOverlay
@onready var health_bar: TextureProgressBar = $HealthBar
@onready var health_bar_anim: AnimationPlayer = $HealthBar/AnimationPlayer

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

func on_damage(_damage, _damager):
	var tween = create_tween()
	tween.tween_property(blood_overlay, "modulate", Color(Color.WHITE, 0.6), 0.1)
	tween.tween_property(blood_overlay, "modulate", Color(Color.WHITE, 0.0), 0.1)
