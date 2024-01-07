extends Control

@onready var play_btn: Button = $VBoxContainer/PlayBtn
@onready var settings_btn: Button = $VBoxContainer/SettingsBtn
@onready var quit_btn: Button = $VBoxContainer/QuitBtn

@onready var settings_panel: Panel = $SettingsPanel

var _on_play_btn_pressed := func():
	get_tree().change_scene_to_file("res://scenes/game.tscn")
	
	Engine.max_fps = Global.settings["target_fps"]
	
var _on_settings_btn_pressed := func():
	settings_panel.visible = !settings_panel.visible

var _on_quit_btn_pressed := func():
	get_tree().quit()

func _ready() -> void:
	play_btn.pressed.connect(_on_play_btn_pressed)
	settings_btn.pressed.connect(_on_settings_btn_pressed)
	quit_btn.pressed.connect(_on_quit_btn_pressed)
