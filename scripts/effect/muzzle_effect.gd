extends Node2D

@onready var timer: Timer = $Timer
@onready var light: PointLight2D = $PointLight2D
@onready var light_timer: Timer = $PointLight2D/Timer

var _on_timeout := func():
	queue_free()

var _on_timeout_light := func():
	light.queue_free()

func _ready() -> void:
	timer.timeout.connect(_on_timeout)
	timer.start()
	
	light_timer.timeout.connect(_on_timeout_light)
	light_timer.start()
