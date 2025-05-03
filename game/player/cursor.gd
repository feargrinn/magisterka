extends MeshInstance3D
class_name Cursor

var tile_position : Vector3i = Vector3i.ZERO
var map : Dictionary[Vector3i, Tile]
var movable : bool = false

const axes_scene = preload("res://ui/axis_planes.tscn")

static func new_cursor(a_map : Dictionary[Vector3i, Tile]) -> Cursor:
	var cursor : Cursor = axes_scene.instantiate()
	#size?
	cursor.scale *= Tile.SIZE
	cursor.position -= Vector3i.ONE * Tile.SIZE/2
	cursor.map = a_map
	cursor.movable = true
	for child : MeshInstance3D in cursor.get_children():
		var material : StandardMaterial3D = child.get_surface_override_material(0)
		material.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
		child.set_surface_override_material(0, material)
	return cursor


func _process(_delta: float) -> void:
	if not movable:
		return
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
	
	if direction != Vector3i.ZERO and map.has(tile_position + direction):
		get_parent().remove_child(self)
		map[tile_position + direction].add_child(self)
		tile_position = tile_position + direction
		
