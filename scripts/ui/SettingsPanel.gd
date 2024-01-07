extends Panel

@onready var use_pp: CheckBox = $ScrollContainer/Options/GraphicsSettings/UsePP
@onready var target_fps: LineEdit = $ScrollContainer/Options/GraphicsSettings/TargetFPS/LineEdit
@onready var english: CheckBox = $ScrollContainer/Options/LanguageSettings/English
@onready var korean: CheckBox = $ScrollContainer/Options/LanguageSettings/Korean
@onready var restart_warning: Label = $ScrollContainer/Options/LanguageSettings/RestartWarning

var _on_pressed_English := func():
	restart_warning.visible = true

var _on_pressed_Korean := func():
	restart_warning.visible = true

func _init() -> void:
	if FileAccess.file_exists("settings.json"):
		var file = FileAccess.open("settings.json", FileAccess.READ)
		Global.settings = JSON.parse_string(file.get_as_text())
		file.close()
		
		Global.current_lang = Global.settings["lang"]

func _ready() -> void:
	english.button_down.connect(_on_pressed_English)
	korean.button_down.connect(_on_pressed_Korean)
	
	if FileAccess.file_exists("settings.json"):
		use_pp.button_pressed = Global.settings["use_pp"]
		target_fps.text = str(Global.settings["target_fps"])
		if Global.settings["lang"] == "English":
			english.button_pressed = true
			korean.button_pressed = false
		elif Global.settings["lang"] == "한국어":
			korean.button_pressed = true
			english.button_pressed = false

func _process(_delta: float) -> void:
	Global.settings["use_pp"] = use_pp.button_pressed
	if target_fps.text.is_valid_int():
		Global.settings["target_fps"] = int(target_fps.text)
	else:
		Global.settings["target_fps"] = 60
	Global.settings["lang"] = Global.current_lang

func _exit_tree() -> void:
	if korean.button_pressed:
		Global.settings["lang"] = "한국어"
	elif english.button_pressed:
		Global.settings["lang"] = "English"
	
	var file = FileAccess.open("settings.json", FileAccess.WRITE)
	file.store_string(JSON.stringify(Global.settings))
	file.close()
