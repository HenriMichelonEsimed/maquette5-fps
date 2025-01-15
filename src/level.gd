class_name Level extends Node3D

@onready var player : Player  = $Player
@onready var level : Node3D = $PocLevel

var enemies : Array[Enemy] = []

func _ready() -> void:
	for spawn_path:EnemySpawnPath in level.find_children("*", "EnemySpawnPath", false):
		if not spawn_path.enemy_scene:
			print("Enemy scene not set")
			continue
		# load and create a new enemy
		var enemy = spawn_path.enemy_scene.instantiate()
		# get a random position in the spawn path curve for the new enemy
		var curve = spawn_path.curve
		var curve_length = curve.get_baked_length()
		var offset = randf()*curve_length
		level.add_child(enemy)
		enemy.position = curve.sample_baked(offset) + spawn_path.position
		enemy.look_at(player.position)
		# add the enemy
		enemies.push_back(enemy)
	
