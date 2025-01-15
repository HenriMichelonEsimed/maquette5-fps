class_name Enemy extends CharacterBody3D

@export var hit_points:int = 100
@export var height:float = 2.0

var hp_bar:Sprite3D = HealthBar.new()

func _ready() -> void:
	hp_bar.hit_points = hit_points
	hp_bar.position.y = height
	add_child(hp_bar)
	
func _process(delta: float) -> void:
	_update_infos()
	
func _update_infos():
	hp_bar.update(hit_points)

func hit(damage:int, hit_position:Vector3) :
	hit_points -= damage
	if (hit_points <= 0):
		hp_bar.queue_free()
		queue_free()
