extends CharacterBody2D


@export var SPEED = 300.0
@export var JUMP_VELOCITY = -400.0
@export var push_force = 100
@export var player = 0
@export var directionOffsetZ = 75.0
@export var jumpScaleForceUp = 0.5
@export var jumpScaleForceDown = 0.5

var collindingNode : CharacterBody2D = null
var pickedItem : CharacterBody2D = null

var isHittingDivider = false
var lastDirection = 1

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

enum PLAYER_STATE {
	STAND,
	JUMP_START,
	FALLING
}

var status = PLAYER_STATE.STAND

func _ready():
	Global.setPlayer(player, self)

func _physics_process(delta):
	if not is_on_floor():
			velocity.y += gravity * delta
			
	if is_on_floor():
		status = PLAYER_STATE.STAND
			
	if Global.activePlayer == player:

		# Handle Jump.
#		if Input.is_action_just_pressed("Jump") and is_on_floor() and status == PLAYER_STATE.STAND:			
#			velocity.y = JUMP_VELOCITY
#			status = PLAYER_STATE.JUMP_START
		
		if Input.is_action_pressed("Jump") and is_on_floor():
			match status:
				PLAYER_STATE.STAND:
					velocity.y = JUMP_VELOCITY
					status = PLAYER_STATE.JUMP_START
				PLAYER_STATE.JUMP_START:
					velocity.y += jumpScaleForceUp
				_:
					pass
			if velocity.y > 0:
				status = PLAYER_STATE.FALLING
			
		if Input.is_action_just_released("Jump") and not is_on_floor() and status != PLAYER_STATE.FALLING:
			status = PLAYER_STATE.FALLING
			velocity.y = move_toward(velocity.y, 0, jumpScaleForceDown)

		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		# Todo change controls
		var direction = Input.get_axis("MoveLeft", "MoveRight")
		if direction:
			velocity.x = direction * SPEED
			lastDirection = direction
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
		
		$Area2D/CollisionShape2D.position.x = sign(lastDirection) * directionOffsetZ
		
		for index in get_slide_collision_count():
			var collision = get_slide_collision(index)
			if collision.get_collider() is RigidBody2D:
				collision.get_collider().apply_central_impulse(-collision.get_normal() * push_force)
		
		#Pick up and drop items
		if Input.is_action_just_pressed("Pickup") :
			if pickedItem != null :
				
				if isHittingDivider:
					return
				
				#drop the item
				pickedItem.held = false
				pickedItem.setCollisions(true)
				
				var itemScale = pickedItem.scale
#				pickedItem.position.x = position.x + ((directionOffsetZ * itemScale.x) * lastDirection)
				pickedItem.position = position + ($Area2D/CollisionShape2D.position * scale)
				pickedItem = null
				collindingNode = null
				
			if collindingNode != null && pickedItem == null:
				pickupItem(collindingNode)
		
		
	if pickedItem != null:
			pickedItem.position = position + ($PickupPosition.position * scale)
	
	changeColorStatus()
	move_and_slide()

func changeColorStatus():
	match status:
		PLAYER_STATE.STAND:
			$Sprite2D.modulate = Color.YELLOW
		PLAYER_STATE.JUMP_START:
			$Sprite2D.modulate = Color.BLUE_VIOLET
		PLAYER_STATE.FALLING:
			$Sprite2D.modulate = Color.RED
		_:
			$Sprite2D.modulate = Color.WHITE

func pickupItem(item):
	pickedItem = item
	pickedItem.held = true
	pickedItem.setCollisions(false)

func dropItem(): #TODO change this to transferItem or something
	pickedItem = null
	collindingNode = null

func _on_area_2d_area_entered(area):
	print("Area Entered %s" % area.name)
	var rootNode = area.get_parent()
	if rootNode != null :
		for group in rootNode.get_groups():
			print("root node %s" % rootNode.name)
			match group:
				"Pickable":
					collindingNode = rootNode
				"Dividers":
					print("Hitting devider")
					isHittingDivider = true
				_ :
					collindingNode = null
	pass # Replace with function body.


func _on_area_2d_area_exited(area):
	print("Area Exit %s" % area.name)
	var rootNode = area.get_parent()
	if rootNode != null :
		for group in rootNode.get_groups():
			print("root node %s" % rootNode.name)
			match group:
				"Dividers":
					print("Exit divider")
					isHittingDivider = false
				_ :
					collindingNode = null
	pass # Replace with function body.
