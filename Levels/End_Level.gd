extends Node2D

@export var laughSound : AudioStream 

# Called when the node enters the scene tree for the first time.
func _ready():
	AudioManager.play(laughSound)	
	pass # Replace with function body.

