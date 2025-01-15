extends Enemy

func hit(damage:int, hit_position:Vector3) :
	if (hit_position.y < 0.6):
		# we hit the "foot"
		damage /= 4
	if (hit_position.y > 2.4):
		# we hit the "head"
		damage *= 2
	super.hit(damage, hit_position)
