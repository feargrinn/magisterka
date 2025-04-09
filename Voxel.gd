extends MeshInstance3D
class_name Voxel

func _init(color : Color) -> void:
	mesh = SphereMesh.new()
	mesh.radius = 0.1
	mesh.height = 0.2
	material_override = StandardMaterial3D.new()
	material_override.albedo_color = color
