extends CharacterBody2D
class_name WaterContainer

@export var side = 0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
#	$Sprinkle.disabled = true
	$Sprinkle.hide()

func spreadWater():
#	$Sprinkle.disabled = false
	$Sprinkle.show()
	if $PickupComponent.activeSprite != null:
		match $PickupComponent.activeSprite.flip_h:
			true:
				$Sprinkle.scale.x = -1
			false:
				$Sprinkle.scale.x = 1

func stopWater():
#	$Sprinkle.disabled = true
	$Sprinkle.hide()

func _physics_process(delta):
	
	if $PickupComponent.held:
		spreadWater()
	else:
		stopWater()
		
	# Add the gravity.
	if not is_on_floor() and not $PickupComponent.held:
		velocity.y += gravity * delta
	move_and_slide()

