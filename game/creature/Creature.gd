extends Area3D
class_name Creature

const creature_scene = preload("res://game/creature/creature.tscn")

static func new_creature() -> Creature:
	var creature : Creature = creature_scene.instantiate()
	return creature


func _on_mouse_entered() -> void:
	var material : StandardMaterial3D = get_child(0).mesh.material
	material.albedo_color = Color.RED


func _on_mouse_exited() -> void:
	var material : StandardMaterial3D = get_child(0).mesh.material
	material.albedo_color = Color.WHITE
