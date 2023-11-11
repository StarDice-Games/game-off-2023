@tool
extends CharacterBody2D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@export var side = 0

func _ready():
		$PickupComponent.setSide(side)

func _process(delta):
	if Engine.is_editor_hint():
		$PickupComponent.setSide(side)

func _physics_process(delta):
	if not Engine.is_editor_hint():
		if $PickupComponent.held:
			return
		# Add the gravity.
		if not is_on_floor():
			velocity.y += gravity * delta

		move_and_slide()

