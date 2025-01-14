class_name Enemy extends CharacterBody3D

@export var hit_points:int = 100

func hit(damage:int, hit_position:Vector3) :
	if (hit_position.y < 0.3):
		# we hit the "foot"
		damage /= 4
	if (hit_position.y > 1.2):
		# we hit the "head"
		damage *= 2
	hit_points -= damage
	print(hit_points)
	if (hit_points <= 0):
		queue_free()
