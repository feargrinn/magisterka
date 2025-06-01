extends Area3D
class_name Box

const box_scene = preload("res://game/creature/box/box.tscn")
var cell_position : Vector3i
var dimensions : Vector3i = Vector3i.ONE

static func new_box(box_position : Vector3i, box_dimensions : Vector3i) -> Box:
	var box : Box = box_scene.instantiate()
	box.cell_position = box_position
	box.dimensions = box_dimensions
	
	var array_mesh_z = box.get_child(2)
	var vertices = PackedVector3Array()
	vertices.push_back(Vector3(-0.2, 0.5, 0.5))
	vertices.push_back(Vector3(0.2, 0.5, 0.5))
	vertices.push_back(Vector3(0.2, 0.2, 0.5))
	
	vertices.push_back(Vector3(-0.2, 0.5, 0.5))
	vertices.push_back(Vector3(0.2, 0.2, 0.5))
	vertices.push_back(Vector3(-0.2, 0.2, 0.5))

	# Initialize the ArrayMesh.
	#var arr_mesh = ArrayMesh.new()
	var arrays = []
	arrays.resize(Mesh.ARRAY_MAX)
	arrays[Mesh.ARRAY_VERTEX] = vertices

	# Create the Mesh.
	array_mesh_z.mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, arrays)
	
	return box

func has_dimension(dimension : Vector3i) -> bool:
	var difference = dimensions - dimension.abs()
	return difference[difference.min_axis_index()] >= 0
