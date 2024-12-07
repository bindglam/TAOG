extends Line2D
class_name Trail

@export var max_length: int

var queue: Array

func _process(delta: float) -> void:
	queue.push_front(get_parent().global_position)
	
	if queue.size() > max_length:
		queue.pop_back()
		
	clear_points()
	
	for point in queue:
		add_point(point)
