extends MeshInstance3D
class_name Cursor

const cursor_scene = preload("res://game/player/cursor.tscn")
var cell_position : Vector3i
var map : Map

const DIRECTIONS : Dictionary = {
	"back" : Vector3i(0, 0, -1),
	"front" : Vector3i(0, 0, 1),
	"left" : Vector3i(-1, 0, 0),
	"right" : Vector3i(1, 0, 0),
	"up" : Vector3i(0, 1, 0),
	"down" : Vector3i(0, -1, 0)
}

static func new_cursor(a_map : Map) -> Cursor:
	var cursor : Cursor = cursor_scene.instantiate()
	cursor.scale *= a_map.CELL_SCALE
	cursor.map = a_map
	return cursor

func get_color(intensity : int) -> Color:
	var color = Color(1, 1, 1)
	if intensity > 0:
		color.b = 0
		@warning_ignore("integer_division")
		color.g = 1 - 1./5 * (intensity - 1)
	return color

func set_cube_color(a_mesh : MeshInstance3D, intensity : int) -> void:
	var alpha = a_mesh.mesh.material.albedo_color.a8
	var color = get_color(intensity)
	a_mesh.mesh.material.albedo_color = color
	a_mesh.mesh.material.albedo_color.a8 = alpha

func _process(_delta: float) -> void:
	var direction = Vector3i.ZERO
	for key in DIRECTIONS:
		if Input.is_action_just_pressed(key):
			direction = DIRECTIONS[key]
	
	if direction != Vector3i.ZERO and map.has_cell_position(cell_position + direction):
		map.set_cursor_at(cell_position + direction)
		set_cube_color(self, map.get_creatures_affecting_cell(cell_position).size())
		for child in get_children():
			var key = child.name
			set_cube_color(child, map.get_creatures_affecting_cell(cell_position + DIRECTIONS[key]).size())
