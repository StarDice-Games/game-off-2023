@tool
extends CharacterBody2D
class_name Spring

@export var side = 0
@export var JUMP_FORCE = 400

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	$PickupComponent.setSide(side)

func _process(delta):
	if Engine.is_editor_hint():
		$PickupComponent.setSide(side)

func _physics_process(delta):
	
	if Engine.is_editor_hint():
		return
	# Add the gravity.
	if not is_on_floor() and not $PickupComponent.held:
		velocity.y += gravity * delta
	
	move_and_slide()

func ApplyForceToPlayer(collider, size):
	if collider is PlatPlayer:
#		var pos = size.position
#		var siz = size.size
#		var height = (collider.position.y - size.position.y) + size.size.y
		
		if $PickupComponent.held == false:
			collider.velocity.y = JUMP_FORCE

func ApplyForceToItems(collider):
	if collider is PlatPlayer:
		return
	if collider is Spring:
		return
	
	for group in collider.get_groups():
		if group == "Pickable":
			if $PickupComponent.held == false:
				collider.velocity.y = JUMP_FORCE
		


func _on_pickup_component_body_entered(body):
	if body != null:
		match $PickupComponent.currentSide:
			0:
				ApplyForceToPlayer(body, null)
			1:
				ApplyForceToItems(body)
	pass # Replace with function body.


#func _on_pickup_component_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
#	if body != null:
#
#		var collision = body.get_child(local_shape_index);
#		var rect = null
#		if collision is CollisionShape2D:
#			print("Collision rect:", collision.shape.get_rect())
#			rect = collision.shape.get_rect()
#
#		if rect != null:
#			match side:
#				0:
#					ApplyForceToPlayer(body, rect)
#				1:
#					ApplyForceToItems(body)
#	pass # Replace with function body.
