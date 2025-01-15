extends Enemy

func hit(damage:int, hit_position:Vector3) :
	if (hit_position.y < 0.3):
		# we hit the "foot"
		damage /= 4
	if (hit_position.y > 1.2):
		# we hit the "head"
		damage *= 2
	super.hit(damage, hit_position)
