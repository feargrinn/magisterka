extends Node3D
class_name Map

var size : int #or Vector3i ig, but assumed int for now
var tiles : Dictionary[Vector3i, Tile] = {}
