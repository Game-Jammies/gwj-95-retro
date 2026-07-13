extends CharacterBody2D

var draggingDistance
var dir
var dragging
var newPosition = Vector2()

@export var draggingSpeed = Vector2(30, 30)

var mouse_in = false

func _ready():
	pass
	
	
func _input(event):
	"""Handles mouse inputs"""
	if event is InputEventMouseButton:
		#if mouse click and held, allow window to be dragged
		if event.is_pressed() && mouse_in:
			draggingDistance = position.distance_to(get_viewport().get_mouse_position())
			dir = (get_viewport().get_mouse_position() - position).normalized()
			dragging = true
			newPosition = get_viewport().get_mouse_position() - draggingDistance * dir
		else:
			dragging = false
			
	elif event is InputEventMouseMotion:
		#drag the window when mouse is moved
		if dragging:
			newPosition = get_viewport().get_mouse_position() - draggingDistance * dir

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
