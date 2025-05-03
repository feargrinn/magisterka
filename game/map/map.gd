extends Node3D
class_name Map

var size : int #or Vector3i ig, but assumed int for now
var tiles : Dictionary[Vector3i, Tile] = {}

var visual_axis_scene = preload("res://ui/axis_planes.tscn")

func _ready() -> void:
	var axes = visual_axis_scene.instantiate()
	axes.scale *= size * Tile.SIZE
	add_child(axes)
