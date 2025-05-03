extends Node3D

const MAP_SIZE = 10

const CREATURE_AMOUNT : int = 10

func _ready() -> void:
	var map : Map = Map.new()
	map.size = MAP_SIZE
	add_child(map)
	for x in range(MAP_SIZE):
		for y in range(MAP_SIZE):
			for z in range(MAP_SIZE):
				var tile = Tile.new(Vector3i(x,y,z))
				map.add_child(tile)
				map.tiles[Vector3i(x, y, z)] = tile
	map.position -= Vector3.ONE * MAP_SIZE/2 * Tile.SIZE #centering the map on the screen
	
	map.tiles[Vector3i.ZERO].add_child(Cursor.new_cursor(map.tiles))
	
	var creature_tiles = map.tiles.keys()
	creature_tiles.shuffle()
	creature_tiles = creature_tiles.slice(0, CREATURE_AMOUNT)
	for creature_tile in creature_tiles:
		var creature = Creature.new_creature()
		map.tiles[creature_tile].add_child(creature)
