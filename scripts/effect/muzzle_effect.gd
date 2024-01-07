extends Node2D

@onready var timer: Timer = $Timer

var _on_timeout := func():
	queue_free()

func _ready() -> void:
	timer.timeout.connect(_on_timeout)
	timer.start()
