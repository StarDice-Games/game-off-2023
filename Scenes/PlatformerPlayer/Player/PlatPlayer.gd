extends CharacterBody2D

@export var SPEED = 300.0
@export var JUMP_VELOCITY = -400.0
@export var push_force = 100
@export var player = 0
@export var directionOffsetZ = 75.0
@export var windResistance = 50.0

var collindingNode : CharacterBody2D = null
var pickedItem : CharacterBody2D = null

var windApplied : Node2D = null
var windLastDirection : Vector2
var windSpeedX = 0.0
var windSpeedY = 0.0

var isHittingDivider = false
var lastDirection = 1
var umblellaDirection = Vector2.ZERO

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	Global.setPlayer(player, self)

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
		var direction = Input.get_axis("MoveLeft", "MoveRight")
		
		var umbrellaVericalDirection = Input.get_axis("UmbrellaUp", "UmbrellaDown")
		var umbrellaHorizontalDirection = Input.get_axis("UmbrellaLeft", "UmbrellaRight")
		
		umblellaDirection.x =  umbrellaHorizontalDirection
		umblellaDirection.y =  umbrellaVericalDirection
				
		$Umbrella.position.x = directionOffsetZ * umblellaDirection.x
		$Umbrella.position.y = directionOffsetZ * umblellaDirection.y
		
		if direction:
			velocity.x = direction * SPEED
			lastDirection = direction
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
		
#		$Area2D/CollisionShape2D.position.x = sign(lastDirection) * directionOffsetZ
		
		if umbrellaVericalDirection != 0 or umbrellaHorizontalDirection != 0:
			#umbrella is open
			if windApplied != null:
				windLastDirection = umblellaDirection.lerp(windApplied.windDirection, 0.8)
				print("Dir:", windLastDirection)	
				velocity.x += windLastDirection.x * windSpeedX
				velocity.y += windLastDirection.y * windSpeedY
				
		#mantain the wind speed a little after exiting the Area
#		windSpeedX = move_toward(windSpeedX, 0, windResistance)
#		windSpeedY = move_toward(windSpeedY, 0, windResistance)
		
		
		
		for index in get_slide_collision_count():
			var collision = get_slide_collision(index)
			if collision.get_collider() is RigidBody2D:
				collision.get_collider().apply_central_impulse(-collision.get_normal() * push_force)
		
		
#	if pickedItem != null:
#			pickedItem.position = position + ($PickupPosition.position * scale)
				
	move_and_slide()

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
				"Winds":
					print("Hitting wind")
					windApplied = rootNode;
					windSpeedX = windApplied.windSpeedX
					windSpeedY = windApplied.windSpeedY
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
				"Winds":
					print("Hitting wind")
					windApplied = null;
				_ :
					collindingNode = null
	pass # Replace with function body.
