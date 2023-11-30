@tool
extends CharacterBody2D


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@export var side = 0

@export var hangTime = 0.0
@export var friction = 1.0
var lastVel

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
			
#			hangTime += 1 * delta
			lastVel = get_real_velocity()
#			debugVelocity("flight velocity:%s", velocity)
#			debugVelocity("flight real:%s", )
			
		if is_on_floor_only():
			debugVelocity("on last real:%s", get_real_velocity())
			if lastVel.x != 0:
				velocity.x = lastVel.x
				lastVel = get_real_velocity()

		move_and_slide()

func debugVelocity(msg, vel):
	if vel.x != 0 or vel.y != 0:
		print(msg % vel)
