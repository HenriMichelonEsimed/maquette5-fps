class_name Weapon extends Node

@export var recoil : float = deg_to_rad(5)
@export var recoil_delay : float = 0.05
@export var dmg : int = 25
@export var range : int = 50

@onready var crosshair : Crosshair = $Crosshair
@onready var raycast : RayCast3D = $LineOfSight
@onready var muzzle_flash : GPUParticles3D = $MuzzleFlash
@onready var muzzle_smoke : GPUParticles3D = $MuzzleSmoke

var recoil_tween : Tween
var crosshair_default_position : Vector2

func _ready() -> void:
	crosshair_default_position = crosshair.position
	raycast.target_position = Vector3(0.0, 0.0, -range)
	raycast.set_collision_mask_value(1, false)
	raycast.set_collision_mask_value(2, false)
	raycast.set_collision_mask_value(3, true)
	set_crosshair_position()
	
func _process(delta: float) -> void:
	if recoil_tween:
		set_crosshair_position()
	if (raycast.is_colliding()) :
		crosshair.set_hit_color()
	else:
		crosshair.set_default_colot()
	crosshair.queue_redraw()

func set_crosshair_position() : 
	crosshair.center.y = get_screen_position_of_raycast_end().y - crosshair_default_position.y
	crosshair.queue_redraw()

func _input(event: InputEvent) -> void:
	if mouse_captured() and Input.is_action_just_pressed("weapon_fire"):
		muzzle_flash.restart()
		muzzle_smoke.restart()
		if raycast.is_colliding():
			var target = raycast.get_collider()
			if target is Enemy:
				target.hit(dmg, raycast.get_collision_point() - target.global_position)
		if recoil_tween:
			recoil_tween.kill()
		recoil_tween = create_tween()
		recoil_tween.tween_property(self, "rotation:x",  self.rotation.x + recoil, recoil_delay)
		recoil_tween.tween_property(raycast, "rotation:x",  self.rotation.x + recoil, recoil_delay)
		recoil_tween.play()
		recoil_tween.tween_callback(recoil_down)

func recoil_down():
	recoil_tween.kill()
	recoil_tween = create_tween()
	recoil_tween.tween_property(self, "rotation:x", 0, recoil_delay)
	recoil_tween.tween_property(raycast, "rotation:x", 0, recoil_delay)
	recoil_tween.play()
	recoil_tween.tween_callback(recoil_end)
	
func recoil_end():
	recoil_tween = null
	set_crosshair_position()
	
func get_screen_position_of_raycast_end():
	var ray_origin = raycast.global_transform.origin
	var ray_end = ray_origin + -raycast.global_transform.basis.z * raycast.target_position.distance_to(ray_origin)
	return get_viewport().get_camera_3d().unproject_position(ray_end)

func mouse_captured() -> bool:
	return Input.mouse_mode == Input.MOUSE_MODE_CAPTURED
