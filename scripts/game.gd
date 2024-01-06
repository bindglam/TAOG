extends Node2D

const BG_SPRITE := preload("res://assets/arts/util/Rectangle.png")

@onready var bg_sprite: Sprite2D = Sprite2D.new()

func _ready() -> void:
	add_child.call_deferred(bg_sprite)
	bg_sprite.z_index = -999
	bg_sprite.texture = BG_SPRITE
	bg_sprite.modulate = Color.BLACK
	bg_sprite.scale = Vector2(999, 999)
	
	y_sort_enabled = true

func _process(_delta: float) -> void:
	bg_sprite.global_position = Global.player.global_position
