extends Node
"""Plays the audio whenever mouse is clicked"""

@onready var audio_player = $SFXPlayer
const snd_down = preload("res://audio/mouse_click_down.mp3")
const snd_up = preload("res://audio/mouse_release.mp3")

var mouse_down: bool = false
var mouse_release: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				mouse_down = true
				audio_player.stream = snd_down
				audio_player.play()
				
				await audio_player.finished
				
				mouse_down = false
				
				if mouse_release:
					play_second()
			else:
				if mouse_down:
					mouse_release = true
				else:
					play_second()
				
func play_second():
	mouse_release = false
	audio_player.stream = snd_up
	audio_player.play()
