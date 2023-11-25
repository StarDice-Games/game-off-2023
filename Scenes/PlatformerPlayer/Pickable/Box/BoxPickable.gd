extends CharacterBody2D
class_name BoxPickup
@export var side = 0

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var afloat = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor() and $PickupComponent.held == false and not afloat:
		velocity.y += gravity * delta
	move_and_slide()
	
	for i in range(0,get_slide_collision_count()):
		var collision = get_slide_collision(i)
		if collision != null:
			var collider = collision.get_collider()
			if collider != null and collider is WaterFloor:
				afloat = true
				remove_from_group("Pickable")
				$PickupComponent.remove_from_group("Pickable")
				if $AnimationPlayer != null:
					$AnimationPlayer.play("float")
