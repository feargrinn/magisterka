extends Node3D

const MAP_SIZE : Vector3i = Vector3i.ONE * 10

const CREATURE_AMOUNT : int = 10

func _ready() -> void:
	var map : Map = Map.new()
	map.size = MAP_SIZE
	add_child(map)
	map.position -= MAP_SIZE/2 * map.CELL_SCALE #centering the map on the screen
	#map.set_scene_at(Vector3i.ZERO, Cursor.new_cursor(map))
	
	for _i in CREATURE_AMOUNT:
		var creature = Creature2D.new_creature()
		creature.cell_position = map.get_random_empty_cell()
		map.set_scene_at(creature.cell_position, creature)
