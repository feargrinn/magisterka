extends MarginContainer
class_name BoxSetter

const setter_scene = preload("res://game/creature/box/BoxSetter.tscn")
var box_position : Vector3i

static func new_boxsetter(future_box_position : Vector3i) -> BoxSetter:
	var box_setter : BoxSetter = setter_scene.instantiate()
	box_setter.box_position = future_box_position
	return box_setter

func get_dimensions() -> Vector3i:
	return Vector3i(1 if $HBoxContainer/X.button_pressed else 0,
		1 if $HBoxContainer/Y.button_pressed else 0,
		1 if $HBoxContainer/Z.button_pressed else 0)

func set_box() -> void:
	var map : Map = get_parent()
	var box = Box.new_box(box_position, get_dimensions())
	map.set_scene_at(box_position, box)
	queue_free()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("set_box"):
		if get_dimensions() != Vector3i.ZERO:
			set_box()
