extends Control

@onready var credits: Label = $ColorRect/Label

func _ready()->void :
	if Global.current_lang == "English":
		credits.text = "TAOG - DEMO









Programming: Octglam(전우빈)
Design: Octglam(전우빈)
Story: Octglam(전우빈), 전수빈
Supporters: gogamza(전희원)







Thanks for playing!





The official version will be released later."
	
	var tween = create_tween()
	tween.tween_property(credits, "position", Vector2(312, - 1600), 30)
	tween.play()
