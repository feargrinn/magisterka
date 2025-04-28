extends Node3D

var tile_scene = preload("res://game/map/tile.tscn")
const MAP_SIZE = 10
@warning_ignore("integer_division")
const OFFSET = MAP_SIZE/2

var map : Dictionary[Vector3i, StaticBody3D] = {}

const CREATURE_AMOUNT : int = 10

var creature_scene = preload("res://game/creature/creature.tscn")

func _ready() -> void:
	var tile = tile_scene.instantiate()
	var size = tile.get_child(0).shape.size.x
	for x in range(-OFFSET, OFFSET):
		for y in range(-OFFSET, OFFSET):
			for z in range(-OFFSET, OFFSET):
				tile = tile_scene.instantiate()
				tile.position = Vector3(x * size + size/2, y * size + size/2, z * size + size/2)
				$Map.add_child(tile)
				map[Vector3i(x + OFFSET, y + OFFSET, z + OFFSET)] = tile
	Cursor.new(map)
	var creature_tiles = map.keys()
	creature_tiles.shuffle()
	creature_tiles = creature_tiles.slice(0, CREATURE_AMOUNT)
	for creature_tile in creature_tiles:
		var creature = creature_scene.instantiate()
		map[creature_tile].add_child(creature)
