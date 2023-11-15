@tool
extends CharacterBody2D
class_name Lamplight

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@export var side = 0
@export var laserLength = 100

@onready var rayCast = $RayCast2D
@onready var line = $Line2D

func _ready():
	rayCast.target_position = Vector2(laserLength, 0)
#	line.clear_points()
#	line.add_point(position)
#	line.add_point(rayCast.target_position)
	
func _process(delta):
#	rayCast.target_position = Vector2(laserLength, 0)
	line.clear_points()
	
	line.add_point(position)
	
	var collisionPoint = rayCast.get_collision_point()
	if collisionPoint != Vector2.ZERO:
		line.add_point(collisionPoint)
	else:
		line.add_point(to_global(Vector2.ZERO))
	pass
	
	

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor() and not Engine.is_editor_hint() and not $PickupComponent.held:
		velocity.y += gravity * delta
	move_and_slide()
