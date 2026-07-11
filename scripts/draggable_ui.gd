extends CharacterBody2D

enum ResizeMode {
	NONE,
	LEFT,
	RIGHT,
	TOP,
	BOTTOM,
	TOP_LEFT,
	TOP_RIGHT,
	BOTTOM_LEFT,
	BOTTOM_RIGHT
}
var MODES: Array[ResizeMode] = [ResizeMode.NONE, ResizeMode.LEFT, ResizeMode.RIGHT, ResizeMode.TOP, ResizeMode.BOTTOM,
ResizeMode.TOP_LEFT, ResizeMode.TOP_RIGHT, ResizeMode.BOTTOM_LEFT, ResizeMode.BOTTOM_RIGHT]
var resize_mode = ResizeMode.NONE

var start_mouse
var start_pos
var start_size
var width
var height

var draggingDistance
var dir
var dragging
var newPosition = Vector2()

@export var draggingSpeed = Vector2(30, 30)
@onready var content = $Content_Sprite #possibly not use sprite2d?
@onready var header = $Head_Sprite
@onready var original_width = $CollisionShape2D.shape.width
@onready var original_height = $CollisionShape2D.shape.height

var mouse_in = false

func _ready():
	pass
	
	
func _input(event):
	"""Handles mouse inputs"""
	if event is InputEventMouseButton:
		#set values for resizing
		start_mouse = get_global_mouse_position()
		start_pos = position
		start_size = content.texture.get_size()
		
		#if mouse click and held, allow window to be dragged
		if event.is_pressed() && mouse_in:
			draggingDistance = position.distance_to(get_viewport().get_mouse_position())
			dir = (get_viewport().get_mouse_position() - position).normalized()
			dragging = true
			newPosition = get_viewport().get_mouse_position() - draggingDistance * dir
		else:
			dragging = false
			
	elif event is InputEventMouseMotion:
		if event.is_pressed() && resize_mode != ResizeMode.NONE:
			handle_resizing()
		#drag the window when mouse is moved, takes less priority than resizing
		elif dragging:
			newPosition = get_viewport().get_mouse_position() - draggingDistance * dir
		
func handle_resizing():
	"""Function that goes thru variables and resizes accordingly"""
	var delta = get_global_mouse_position() - start_mouse
	if resize_mode == ResizeMode.RIGHT:
		width = start_size.x + delta.x
		
	
	"""Resize all elements"""
	header.scale.x = width / original_width #don't scale header height
	content.scale.x = width / original_width
	content.scale.y = height / original_height
	$CollisionShape2D.shape.size = Vector2(width, height)
	$ResizeRight.positioin.x = width/2
		
		
func _physics_process(delta):
	#slides the window around
	if dragging:
		velocity = (newPosition - position) * draggingSpeed
		move_and_slide() #cool function that does stuff for me 
	
func mouse_entered():
	mouse_in = true

func mouse_exited():
	mouse_in = false

func _on_close_pressed():
	#destroy itself when closed
	get_parent().remove_child(self)
	self.queue_free()

#resizing functions
func resize_reset():
	resize_mode = ResizeMode.NONE
	print(resize_mode)

func resize_set_mode(new_mode: int):
	resize_mode = MODES[new_mode]
	print(resize_mode)
