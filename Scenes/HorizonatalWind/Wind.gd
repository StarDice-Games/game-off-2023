extends Node2D

@export var windDirection = Vector2.ZERO
@export var windSpeedX = 100.0
@export var windSpeedY = 100.0
@export var impulse = false

@export var particleSpeed = Vector2.ZERO


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	$CPUParticles2D.gravity = particleSpeed
	pass
