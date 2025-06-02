extends GridMap
class_name Map

const CELL_SCALE : float = 0.1
const CELL_SIZE : Vector3 = Vector3.ONE * CELL_SCALE
var size : Vector3i
var creatures : Dictionary[Vector3i, Creature] = {}
var cursor : Cursor
var boxes : Dictionary[Vector3i, Box] = {}

var setting_box : bool = false

var visual_axis_scene = preload("res://ui/axis_planes.tscn")

const DIRECTIONS : Dictionary = {
	"front" : Vector3i(0, 0, -1),
	"back" : Vector3i(0, 0, 1),
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

func _input(event: InputEvent):
	if not setting_box and event.is_action_pressed("set_box"):
		setting_box = true
		add_child(BoxSetter.new_boxsetter(cursor.cell_position), true)

func _set_creature_at(cell_position : Vector3i, creature : Creature) -> void:
	creature.scale *= CELL_SCALE * 2./3
	creatures[cell_position] = creature
	creature.position = map_to_local(cell_position)
	creature.cell_position = cell_position
	add_child(creature, true)

func _game_finished() -> bool:
	for creature_position in creatures:
		if !boxes.has(creature_position):
			return false
		else:
			if boxes[creature_position].dimensions != creatures[creature_position].dimensions:
				return false
	return true

func _set_box_at(cell_position : Vector3i, box : Box) -> void:
	boxes[cell_position] = box
	box.scale *= CELL_SCALE
	box.position = map_to_local(cell_position)
	box.cell_position = cell_position
	add_child(box, true)
	setting_box = false
	if _game_finished():
		print("You win, good job!")
		get_tree().quit()

func set_scene_at(cell_position : Vector3i, scene : Node) -> bool:
	if AABB(Vector3i.ZERO, size).has_point(cell_position):
		if scene is Creature:
			_set_creature_at(cell_position, scene)
		elif scene is Box:
			_set_box_at(cell_position, scene)
		return true
	return false

func has_cell_position(cell_position : Vector3i) -> bool:
	return AABB(Vector3i.ZERO, size - Vector3i.ONE).has_point(cell_position)

func get_scene_at(cell_position : Vector3i) -> Node3D:
	return creatures[cell_position]

# This shows a cross of width 3x3 (when neighbourhood is 1) on cursor axes
func _update_creature_visibility(cell_position : Vector3i) -> void:
	const VISIBILITY_NEIGHBOURHOOD = 1
	for creature : Creature in creatures.values():
		var distance : Vector3i = abs(creature.cell_position - cell_position)
		distance[distance.max_axis_index()] = 0
		if distance.length_squared() <= VISIBILITY_NEIGHBOURHOOD * 2:
			creature.show()
		else:
			creature.hide()

func set_cursor_at(cell_position : Vector3i):
	cursor.position = map_to_local(cell_position)
	cursor.cell_position = cell_position
	_update_creature_visibility(cell_position)

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
			if creature.has_dimension(DIRECTIONS[direction]):
				neighbours.append(creature)
	return neighbours
