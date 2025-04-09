extends MeshInstance3D
class_name Voxel

func _init(color : Color) -> void:
	material_override = StandardMaterial3D.new()
	material_override.albedo_color = color
