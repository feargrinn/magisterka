extends GridMap
class_name Map

const CELL_SCALE : float = 0.1
const CELL_SIZE : Vector3 = Vector3.ONE * CELL_SCALE
var size : Vector3i
var tiles : Dictionary[Vector3i, Node3D] = {}

var visual_axis_scene = preload("res://ui/axis_planes.tscn")

func _ready() -> void:
	cell_size = CELL_SIZE
	var axes = visual_axis_scene.instantiate()
	axes.scale *= size * CELL_SCALE
	add_child(axes)

func set_scene_at(cell_position : Vector3i, scene : Node3D) -> bool:
	if AABB(Vector3i.ZERO, size).has_point(cell_position) and !tiles.has(cell_position):
		tiles[cell_position] = scene
		add_child(scene, true)
		scene.position = map_to_local(cell_position)
		return true
	return false

func get_scene_at(cell_position : Vector3i) -> Node3D:
	return tiles[cell_position]

func get_random_empty_cell() -> Vector3i:
	var random_cell = Vector3i.ZERO
	random_cell.x = randi() % size.x
	random_cell.y = randi() % size.y
	random_cell.z = randi() % size.z
	if tiles.has(random_cell):
		return get_random_empty_cell()
	return random_cell
