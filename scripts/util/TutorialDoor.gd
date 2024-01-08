extends Area2D

const BALLON := preload("res://dialogues/balloon.tscn")
const ENDING_CREDITS_SCENE := preload("res://scenes/ui/ending_credits.tscn")

@onready var audio_stream_player := get_parent().get_node("AudioStreamPlayer2D")

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and not get_parent().get_parent().has_node("ThisWay"):
		for body in get_overlapping_bodies():
			if not body is Player: continue
			get_parent().play("default")
			audio_stream_player.play()
			
			Global.player.player_ui.switch_screen(Color.WHITE, Color.WHITE, 3.0)
			if Global.is_demo:
				await get_tree().create_timer(3.0).timeout
				get_tree().change_scene_to_packed(ENDING_CREDITS_SCENE)
