extends Node2D

const BALLON := preload("res://dialogues/balloon.tscn")
const ENEMY_SCENE := preload("res://scenes/character/regressors_1.tscn")

@onready var first_enemy_spawner: Node2D = $FirstEnemySpawner
@onready var second_enemy_spawners: Node2D = $SecondEnemySpawners
@onready var second_enemies: Node2D = $SecondEnemies
@onready var this_way_anim: AnimationPlayer = $ThisWay/AnimationPlayer

var is_player_moved = false

var _first_enemy_on_death := func():
	spawn_dialogue("res://dialogues/tutorial_kr.dialogue", "res://dialogues/tutorial_en.dialogue",\
					"start_3")
	get_tree().current_scene.get_node("CanvasModulate").visible = true
	for spawner in second_enemy_spawners.get_children():
		var enemy := ENEMY_SCENE.instantiate()
		second_enemies.add_child.call_deferred(enemy)
		enemy.global_position = spawner.global_position

var _player_on_move := func(_dir):
	if not is_player_moved:
		spawn_dialogue("res://dialogues/tutorial_kr.dialogue", "res://dialogues/tutorial_en.dialogue",\
					"start_2")
		
		var enemy := ENEMY_SCENE.instantiate()
		add_child.call_deferred(enemy)
		enemy.global_position = first_enemy_spawner.global_position
		enemy.on_death.connect(_first_enemy_on_death)
	is_player_moved = true

func _ready() -> void:
	Global.player.on_move.connect(_player_on_move)
	Global.current_map = self
	
	this_way_anim.play("default")
	
	spawn_dialogue("res://dialogues/tutorial_kr.dialogue", "res://dialogues/tutorial_en.dialogue",\
					"start_1")

func spawn_dialogue(kr_path, en_path, start):
	var ballon: Node = BALLON.instantiate()
	get_tree().current_scene.add_child.call_deferred(ballon)
	if Global.current_lang == "한국어":
		ballon.start(load(kr_path), start)
	else:
		ballon.start(load(en_path), start)
