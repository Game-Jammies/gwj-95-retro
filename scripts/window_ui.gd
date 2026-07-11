extends PanelContainer

# Node references
@onready var title_bar = $VBoxContainer/TitleBar
@onready var resize_handle = $ResizeHandle

# Dragging states
var dragging = false
var drag_offset = Vector2.ZERO

# Resizing states
var resizing = false
@export var min_size = Vector2(200, 150) # Set your minimum window constraints

func _ready():
	# Connect GUI input events to handle clicks
	title_bar.gui_input.connect(_on_title_bar_input)
	resize_handle.gui_input.connect(_on_resize_handle_input)

func _process(_delta):
	var mouse_pos = get_global_mouse_position()
	
	# Handle Window Dragging
	if dragging:
		global_position = mouse_pos - drag_offset
		
	# Handle Window Resizing
	if resizing:
		var new_size = mouse_pos - global_position
		# Enforce boundaries
		size.x = max(new_size.x, min_size.x)
		size.y = max(new_size.y, min_size.y)

func _on_title_bar_input(event: InputEvent):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			dragging = true
			drag_offset = get_global_mouse_position() - global_position
			# Bring window to front when clicked
			get_parent().move_child(self, -1)
		else:
			dragging = false

func _on_resize_handle_input(event: InputEvent):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			resizing = true
		else:
			resizing = false
