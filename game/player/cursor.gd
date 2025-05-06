extends MeshInstance3D
class_name Cursor

const cursor_scene = preload("res://game/player/cursor.tscn")
var cell_position : Vector3i
var map : Map


static func new_cursor(a_map : Map) -> Cursor:
	var cursor : Cursor = cursor_scene.instantiate()
	cursor.scale *= a_map.CELL_SCALE
	cursor.map = a_map
	return cursor


func _process(_delta: float) -> void:
	var direction = Vector3i.ZERO
	if Input.is_action_just_pressed("back"): 
		direction = Vector3i(0, 0, 1)
	elif Input.is_action_just_pressed("front"): 
		direction = Vector3i(0, 0, -1)
	elif Input.is_action_just_pressed("left"): 
		direction = Vector3i(-1, 0, 0)
	elif Input.is_action_just_pressed("right"): 
		direction = Vector3i(1, 0, 0)
	elif Input.is_action_just_pressed("up"): 
		direction = Vector3i(0, 1, 0)
	elif Input.is_action_just_pressed("down"): 
		direction = Vector3i(0, -1, 0)
	if direction != Vector3i.ZERO and map.has_cell_position(cell_position + direction):
		map.move_scene_at(cell_position, direction)
		
