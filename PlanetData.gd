extends Node
class_name PlanetData

var radius = 10

const ACCURACY = 8

var inside_color : Dictionary
var outside_color : Dictionary

func _init(color : Color = Color.REBECCA_PURPLE) -> void:
	for theta in range(0, 360, 360./ACCURACY): 
		for phi in range(0, 360, 360./ACCURACY):
			outside_color[Vector3(radius,0,0).rotated(Vector3(0,1,0),cos(theta)).rotated(Vector3(1,0,0), cos(phi))] = color
