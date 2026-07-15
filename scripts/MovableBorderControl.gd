extends Control
class_name MovableBorderControl

@export_category("Logic")
@export var move_target: Control

var is_hover: bool
var is_grab: bool
var mouse_down_pos: Vector2 

func _ready() -> void:
	mouse_entered.connect(func(): is_hover = true)
	mouse_exited.connect(func(): is_hover = false)
	
func _process(delta: float) -> void:
	if is_hover and Input.is_action_just_pressed("Left Mouse Button"):
		mouse_down_pos = get_viewport().get_mouse_position()
		is_grab = true
	
	if Input.is_action_just_released("Left Mouse Button"):
		is_grab = false
		
	if is_grab:
		var current_mouse_pos: Vector2 = get_viewport().get_mouse_position()
		var offset: Vector2 = current_mouse_pos - mouse_down_pos
		move_target.position += offset
		mouse_down_pos = current_mouse_pos
