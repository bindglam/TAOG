class_name TranslationControl
extends Control

@export var language_file: String
@export var translation_property: String

var language_data: Dictionary = {}

func _ready() -> void:
	if not FileAccess.file_exists("data/translations/"+language_file+".json"):
		printerr("Translation file not found!")
		return
	var file = FileAccess.open("data/translations/"+language_file+".json", FileAccess.READ)
	var data = JSON.parse_string(file.get_as_text())
	file.close()
	language_data = data
	
	set(translation_property, language_data[Global.current_lang])
