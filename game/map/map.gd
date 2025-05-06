extends GridMap
class_name Map

const CELL_SCALE : float = 0.1
const CELL_SIZE : Vector3 = Vector3.ONE * CELL_SCALE
var size : Vector3i
var creatures : Dictionary[Vector3i, Creature] = {}
var cursor : Cursor

var visual_axis_scene = preload("res://ui/axis_planes.tscn")

const DIRECTIONS : Dictionary = {
	"back" : Vector3i(0, 0, 1),
	"front" : Vector3i(0, 0, -1),
	"left" : Vector3i(-1, 0, 0),
	"right" : Vector3i(1, 0, 0),
	"up" : Vector3i(0, 1, 0),
	"down" : Vector3i(0, -1, 0)
}

func _ready() -> void:
	cell_size = CELL_SIZE
	var axes = visual_axis_scene.instantiate()
	axes.scale *= size * CELL_SCALE
	add_child(axes)

func set_creature_at(cell_position : Vector3i, creature : Creature) -> bool:
	if AABB(Vector3i.ZERO, size).has_point(cell_position):
		creatures[cell_position] = creature
		creature.position = map_to_local(cell_position)
		creature.cell_position = cell_position
		add_child(creature, true)
		return true
	return false

func has_cell_position(cell_position : Vector3i) -> bool:
	return AABB(Vector3i.ZERO, size - Vector3i.ONE).has_point(cell_position)

func get_scene_at(cell_position : Vector3i) -> Node3D:
	return creatures[cell_position]

func set_cursor_at(cell_position : Vector3i):
	cursor.position = map_to_local(cell_position)
	cursor.cell_position = cell_position


func get_random_empty_cell() -> Vector3i:
	var random_cell = Vector3i.ZERO
	random_cell.x = randi() % size.x
	random_cell.y = randi() % size.y
	random_cell.z = randi() % size.z
	if creatures.has(random_cell):
		return get_random_empty_cell()
	return random_cell

func get_creatures_affecting_cell(cell_position : Vector3i) -> Array[Creature]:
	var neighbours : Array[Creature] = []
	for direction in DIRECTIONS:
		var neighbour_cell = cell_position + DIRECTIONS[direction]
		if creatures.has(neighbour_cell):
			var creature : Creature = creatures[neighbour_cell]
			if (creature.dimensions - DIRECTIONS[direction].abs())[(creature.dimensions - DIRECTIONS[direction].abs()).min_axis_index()] >= 0:
				neighbours.append(creature)
	return neighbours
