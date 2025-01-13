class_name Crosshair extends Control

func _draw():
	draw_line(Vector2(-10.0, 0.0), Vector2(10.0, 0.0), Color.GREEN, 1.0)
	draw_line(Vector2(0.0, -10.0), Vector2(0.0, 10.0), Color.GREEN, 1.0)
