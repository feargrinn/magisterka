extends Node3D

var tile_scene = preload("res://tile.tscn")
const MAP_SIZE = 10

func _ready() -> void:
	var tile = tile_scene.instantiate()
	var size = tile.get_child(0).shape.size.x
	@warning_ignore_start("integer_division")
	for x in range(-MAP_SIZE/2, MAP_SIZE/2):
		for y in range(-MAP_SIZE/2, MAP_SIZE/2):
			for z in range(-MAP_SIZE/2, MAP_SIZE/2):
				@warning_ignore_restore("integer_division")
				tile = tile_scene.instantiate()
				tile.position = Vector3(x * size + size/2, y * size + size/2, z * size + size/2)
				add_child(tile)
