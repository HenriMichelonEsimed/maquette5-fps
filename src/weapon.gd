class_name Weapon extends Node

@export var recoil : float = deg_to_rad(5)

var recoil_tween : Tween

func _input(event: InputEvent) -> void:
	if mouse_captured() and Input.is_action_just_pressed("weapon_fire"):
		print("fire")
		if recoil_tween:
			recoil_tween.kill()
		recoil_tween = create_tween()
		var rot = self.rotation
		rot.x += recoil
		recoil_tween.tween_property(self, "rotation", rot, 0.05)
		recoil_tween.play()
		recoil_tween.tween_callback(recoil_end)
		
func recoil_end():
		recoil_tween.kill()
		recoil_tween = create_tween()
		var rot = self.rotation
		rot.x -= recoil
		recoil_tween.tween_property(self, "rotation", rot, 0.05)
		recoil_tween.play()
	

func mouse_captured() -> bool:
	return Input.mouse_mode == Input.MOUSE_MODE_CAPTURED
