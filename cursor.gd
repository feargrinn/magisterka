extends MeshInstance3D
class_name Cursor

var tile_position : Vector3i = Vector3i.ZERO
var map : Dictionary[Vector3i, StaticBody3D]

func _init(map_a : Dictionary[Vector3i, StaticBody3D]) -> void:
	mesh = SphereMesh.new()
	mesh.radius = 0.05
	mesh.height = 0.1
	map = map_a
	map[tile_position].add_child(self)

func _process(_delta: float) -> void:
	var direction = Vector3i.ZERO
	if Input.is_action_just_pressed("back"): 
		direction = Vector3i(0, 0, 1)
	elif Input.is_action_just_pressed("front"): 
		direction = Vector3i(0, 0, -1)
	elif Input.is_action_just_pressed("left"): 
		direction = Vector3i(-1, 0, 0)
	elif Input.is_action_just_pressed("right"): 
		direction = Vector3i(1, 0, 0)
	elif Input.is_action_just_pressed("up"): 
		direction = Vector3i(0, 1, 0)
	elif Input.is_action_just_pressed("down"): 
		direction = Vector3i(0, -1, 0)
	
	if map.has(tile_position + direction):
		get_parent().remove_child(self)
		map[tile_position + direction].add_child(self)
		tile_position = tile_position + direction
		
