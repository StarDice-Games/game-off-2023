extends CharacterBody2D
class_name Lamplight

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@export var side = 0

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor() and not Engine.is_editor_hint() and not $PickupComponent.held:
		velocity.y += gravity * delta
	move_and_slide()
