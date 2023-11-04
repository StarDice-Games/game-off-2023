extends CharacterBody2D


@export var SPEED = 300.0
@export var JUMP_VELOCITY = -400.0
@export var push_force = 100
@export var player = 0
@export var directionOffsetZ = 75.0

var collindingNode : RigidBody2D = null
var pickedItem : RigidBody2D = null

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	if not is_on_floor():
			velocity.y += gravity * delta
			
	if Global.activePlayer == player:

		# Handle Jump.
		if Input.is_action_just_pressed("Jump") and is_on_floor():
			velocity.y = JUMP_VELOCITY

		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		# Todo change controls
		var direction = Input.get_axis("ui_left", "ui_right")
		if direction:
			velocity.x = direction * SPEED
			
			$Area2D/CollisionShape2D.position.x = direction * directionOffsetZ
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
		
		for index in get_slide_collision_count():
			var collision = get_slide_collision(index)
			if collision.get_collider() is RigidBody2D:
				collision.get_collider().apply_central_impulse(-collision.get_normal() * push_force)
		
		#Pick up and drop items
		if Input.is_action_just_pressed("Pickup") :
			if pickedItem != null :
				#drop the item
				pickedItem.freeze = false
				pickedItem.position = position
				pickedItem = null
				collindingNode = null
			if collindingNode != null && pickedItem == null:
				collindingNode.freeze = true
				pickedItem = collindingNode
		
		if pickedItem != null:
			pickedItem.position = position + $PickupPosition.position
	
	move_and_slide()


func _on_area_2d_area_entered(area):
	print("Area Entered %s" % area.name)
	var rootNode = area.get_parent()
	if rootNode != null && rootNode is RigidBody2D:
		for group in rootNode.get_groups():
			print("root node %s" % rootNode.name)
			if group == "Pickable":
				collindingNode = rootNode
			else :
				collindingNode = null
	pass # Replace with function body.
