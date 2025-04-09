extends Node
class_name PlanetData

const RADIUS = 1

const ACCURACY = 80

var inside_color : Dictionary
var outside_color : Dictionary

func _init(color : Color = Color.REBECCA_PURPLE) -> void:
	for theta in range(0, 360, 360./ACCURACY): 
		for phi in range(0, 360, 360./ACCURACY):
			var point : Vector3
			point.y = sin(deg_to_rad(phi)) * RADIUS
			point.x = cos(deg_to_rad(theta))*cos(deg_to_rad(phi)) * RADIUS
			point.z = sin(deg_to_rad(theta))*cos(deg_to_rad(phi)) * RADIUS
			
			outside_color[point] = color
