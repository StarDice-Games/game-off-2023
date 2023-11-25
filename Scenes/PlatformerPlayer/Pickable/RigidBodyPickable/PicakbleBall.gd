@tool
extends RigidBody2D
class_name Ball

@export var side = 0
@export var massLeft = 1
@export var massRight = 1
@export var speedBeforePlayingSound = 20

@export_category("Audio")
@export var rollingSoundBig : AudioStream
@export var rollingSoundSmall : AudioStream

var canPlaySound = true

# Called when the node enters the scene tree for the first time.
func _ready():
	#overwrite the value when in game
	$PickupComponent.setSide(side)
	
	angular_velocity
	
	pass # Replace with function body.

func setMass(val):
	match side:
		0: 
			mass = massLeft
		1:
			mass = massRight

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Engine.is_editor_hint():
		$PickupComponent.setSide(side)
	
	pass

func _physics_process(delta):
	if linear_velocity.length() > speedBeforePlayingSound and canPlaySound:
		if $PickupComponent.held == true:
			return
		canPlaySound = false
		match $PickupComponent.currentSide:
			1: 
				AudioManager.play(rollingSoundBig)
				$WaitForSoundToStop.start(rollingSoundBig.get_length())
			0:
				AudioManager.play(rollingSoundSmall)
				$WaitForSoundToStop.start(rollingSoundSmall.get_length())


func _on_wait_for_sound_to_stop_timeout():
	canPlaySound = true
	pass # Replace with function body.
