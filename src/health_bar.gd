class_name HealthBar extends Sprite3D
# https://kidscancode.org/godot_recipes/4.x/3d/healthbars/

@export var hit_points: float

const bar_green:Texture2D = preload("res://res/textures/hp_bar_green.png")
const bar_yellow:Texture2D = preload("res://res/textures/hp_bar_yellow.png")
const bar_orange:Texture2D = preload("res://res/textures/hp_bar_orange.png")

var hp_bar_texture:TextureProgressBar = TextureProgressBar.new()

func _ready() -> void:
	hide()
	billboard = BaseMaterial3D.BILLBOARD_ENABLED
	hp_bar_texture.texture_progress = bar_green
	hp_bar_texture.max_value = hit_points
	hp_bar_texture.value = hit_points
	var subviewport = SubViewport.new()
	subviewport.disable_3d = true
	subviewport.transparent_bg = true
	subviewport.handle_input_locally = false
	subviewport.size = Vector2i(150,25)
	subviewport.render_target_update_mode = SubViewport.UPDATE_ALWAYS
	subviewport.add_child(hp_bar_texture)
	texture = subviewport.get_texture()
	add_child(subviewport)

func update(value):
	hp_bar_texture.value = value
	if value < hit_points:
		show()
	hp_bar_texture.texture_progress = bar_green
	if value < 0.75 * hit_points:
		hp_bar_texture.texture_progress = bar_yellow
	if value < 0.5 * hit_points:
		hp_bar_texture.texture_progress = bar_orange
