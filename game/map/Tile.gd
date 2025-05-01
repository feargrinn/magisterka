extends StaticBody3D
class_name Tile

static var SIZE : float = 0.1

func _init(position_on_map : Vector3i) -> void:
	var debug_shape = CollisionShape3D.new()
	debug_shape.shape = BoxShape3D.new()
	debug_shape.shape.size = Vector3.ONE * SIZE
	add_child(debug_shape)
	position = Vector3(position_on_map.x * SIZE + SIZE/2, 
		position_on_map.y * SIZE + SIZE/2, 
		position_on_map.z * SIZE + SIZE/2)
