extends Node3D

@onready var player : Player  = $Player
@onready var level : Node3D = $PocLevel
var enemies : Array[Enemy] = []

func _ready() -> void:
	var spawn_path = level.get_node("EnemySpawnPath")
	if (spawn_path != null):
		var enemy_scene = load("res://scenes/enemy.tscn")
		var enemy = enemy_scene.instantiate()
		var curve = spawn_path.curve
		var curve_length = curve.get_baked_length()
		var offset = randf()*curve_length
		enemy.position = curve.sample_baked(offset) + spawn_path.position
		enemy.look_at(player.position)
		enemies.push_back(enemy)
		level.add_child(enemy)
		
	
	
	
