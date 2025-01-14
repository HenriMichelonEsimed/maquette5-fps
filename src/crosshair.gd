class_name Crosshair extends Control

@export var length : float = 10.0
@export var color_default : Color = Color.GREEN
@export var color_hit : Color = Color.RED

var center : Vector2 = Vector2.ZERO
var color : Color = color_default

func _draw():
	draw_line(Vector2(-length + center.x, center.y), Vector2(length + center.x, center.y), color, 1.0)
	draw_line(Vector2(center.x, -length + center.y), Vector2(center.x, length + center.y), color, 1.0)
	
func set_hit_color():
	color = color_hit
	
func set_default_colot():
	color = color_default
