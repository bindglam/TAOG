extends Area2D

const BALLON := preload("res://dialogues/balloon.tscn")

var is_interacted := false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		for body in get_overlapping_bodies():
			if not body is Player: continue
			get_parent().get_node("ThisWay").queue_free()
			spawn_dialogue("res://dialogues/tutorial_kr.dialogue", "res://dialogues/tutorial_en.dialogue",\
					"start_4")
			get_tree().current_scene.get_node("CanvasModulate").color = Color.RED
			is_interacted = true

func _process(_delta: float) -> void:
	if is_interacted:
		Global.player.camera.shake(4, 1)

func spawn_dialogue(kr_path, en_path, start):
	var ballon: Node = BALLON.instantiate()
	get_tree().current_scene.add_child.call_deferred(ballon)
	if Global.current_lang == "한국어":
		ballon.start(load(kr_path), start)
	else:
		ballon.start(load(en_path), start)
