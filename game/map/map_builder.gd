extends Node3D

const MAP_SIZE : Vector3i = Vector3i.ONE * 10

const CREATURE_DENSITY : float = 0.3

func get_creature_amount() -> int:
	var possible_amount : int = MAP_SIZE.x * MAP_SIZE.y * MAP_SIZE.z
	@warning_ignore("narrowing_conversion")
	return possible_amount * CREATURE_DENSITY

func _ready() -> void:
	var map : Map = Map.new()
	map.size = MAP_SIZE
	add_child(map, true)
	map.position -= MAP_SIZE/2 * map.CELL_SCALE #centering the map on the screen
	
	var cursor = Cursor.new_cursor(map)
	map.cursor = cursor
	map.add_child(cursor, true)
	map.set_cursor_at(MAP_SIZE/2)
	
	for _i in get_creature_amount():
		var creature = Creature2D.new_creature()
		map.set_scene_at(map.get_random_empty_cell(), creature)
