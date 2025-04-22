extends Node3D

var currently_rotating : bool = false

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_MIDDLE:
		currently_rotating = event.pressed
	
	if event is InputEventMouseMotion and currently_rotating:
		var moved_by = event.relative
		rotation.y = rotation.y - moved_by.x / 200
		rotation.x = rotation.x - moved_by.y / 400
