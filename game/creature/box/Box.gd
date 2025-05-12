extends Area3D
class_name Box

const box_scene = preload("res://game/creature/box/box.tscn")
var cell_position : Vector3i
var dimensions : Vector3i = Vector3i.ONE

static func new_box(box_position : Vector3i, box_dimensions : Vector3i) -> Box:
	var box : Box = box_scene.instantiate()
	box.cell_position = box_position
	box.dimensions = box_dimensions
	return box

func has_dimension(dimension : Vector3i) -> bool:
	var difference = dimensions - dimension.abs()
	return difference[difference.min_axis_index()] >= 0
