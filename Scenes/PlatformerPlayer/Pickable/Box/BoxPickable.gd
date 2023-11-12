extends CharacterBody2D

@export var side = 0

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor() and $PickupComponent.held == false:
		velocity.y += gravity * delta
	move_and_slide()
