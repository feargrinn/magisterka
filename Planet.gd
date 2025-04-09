extends Node
class_name Planet

var position : Vector3
var planet_data : PlanetData
#var camera : Camera #?

func _init() -> void:
	planet_data = PlanetData.new()

#var rockets : Array[Rocket]
func _ready() -> void:
	for voxel_position in planet_data.outside_color:
		print(voxel_position)
		var voxel = Voxel.new(planet_data.outside_color[voxel_position])
		voxel.position = voxel_position
		add_child(voxel)
