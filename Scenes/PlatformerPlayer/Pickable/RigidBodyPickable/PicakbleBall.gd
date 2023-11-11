@tool
extends RigidBody2D
class_name Ball

@export var side = 0
@export var massLeft = 1
@export var massRight = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	#overwrite the value when in game
	$PickupComponent.setSide(side)
	
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
