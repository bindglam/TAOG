extends BeehaveTree

@export_node_path("Area2D") var distance_area_path: NodePath
@export var detect_enemies_name: PackedStringArray

@onready var has_enemy_in_distance_action1 = $SelectorComposite/MoveToEnemy/HasEnemyInDistance

func _ready() -> void:
	await get_tree().root.ready
	has_enemy_in_distance_action1.distance_area = get_node(distance_area_path)
	has_enemy_in_distance_action1.detect_enemies = detect_enemies_name
