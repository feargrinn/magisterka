extends Creature
class_name Creature1D

@warning_ignore("shadowed_variable_base_class")
static func new_creature(dimensions : Vector3i = Vector3i.ZERO) -> Creature1D:
	var creature : Creature = Creature.new_creature()
	if dimensions:
		if dimensions.length_squared() == 1:
			creature.dimensions = dimensions
		else:
			print_debug("Wrong 1D creature dimensions!")
			return null
	else:
		var random_orientation : int = randi()
		creature.dimensions = Vector3i(0 if random_orientation % 3 else 1, 
			0 if (random_orientation + 1) % 3 else 1, 
			0 if (random_orientation + 2) % 3 else 1)
	return creature
