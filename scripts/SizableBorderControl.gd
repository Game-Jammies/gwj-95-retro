extends Control
class_name SizableBorderControl

"""TODO: Fix resizing beyond minimum borders to match windows behavior?"""
enum SizeChange {
	Horizontal,
	Vertical,
	Both
}

@export var size_change_target : Control
@export var size_change_type: SizeChange
@export var invert_x: bool
@export var invert_y: bool

var is_hover: bool
var is_grab: bool
var mouse_down_pos: Vector2 

#var parent
#var min_size: Vector2

func _ready() -> void:
	mouse_entered.connect(func(): is_hover = true)
	mouse_exited.connect(func(): is_hover = false)
	#parent = get_parent().get_parent() as WindowControl
	#min_size = parent.min_size
	
func _process(delta: float) -> void:
	if is_hover && Input.is_action_just_pressed("Left Mouse Button"):
		mouse_down_pos = get_viewport().get_mouse_position()
		is_grab = true
		
	if Input.is_action_just_released("Left Mouse Button"):
		is_grab = false
	
	if is_grab:
		var current_mouse_pos: Vector2 = get_viewport().get_mouse_position()
		var offset: Vector2 = current_mouse_pos - mouse_down_pos
		
		match size_change_type:
			SizeChange.Horizontal:
				if invert_x:
					size_change_target.size.x -= offset.x
					size_change_target.position.x += offset.x
				else:
					size_change_target.size.x += offset.x
			SizeChange.Vertical:
				if invert_y:
					size_change_target.size.y -= offset.y
					size_change_target.position.y += offset.y
				else:
					size_change_target.size.y += offset.y
			SizeChange.Both:
				if invert_x:
					size_change_target.size.x -= offset.x
					size_change_target.position.x += offset.x
				else:
					size_change_target.size.x += offset.x
				if invert_y:
					size_change_target.size.y -= offset.y
					size_change_target.position.y += offset.y
				else:
					size_change_target.size.y += offset.y
			_: #case default
				size_change_target.size += offset
			#end match
		
		mouse_down_pos = current_mouse_pos
