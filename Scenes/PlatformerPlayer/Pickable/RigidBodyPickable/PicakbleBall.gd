@tool
extends RigidBody2D

@export var side = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	#overwrite the value when in game
	$PickupComponent.setSide(side)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Engine.is_editor_hint():
		$PickupComponent.setSide(side)
	
	pass
