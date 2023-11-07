@tool
extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var held = false
@export var currentSide = 0

var leftElement = []
var rightElement = []

func _ready():
	leftElement.append_array([
		$LeftSideSprite, 
		$LeftSizeCollisions,
		$Area2D/PickupAreaLeft
	])
	
	rightElement.append_array([
		$RightSideSprite, 
		$RightSizeCollisions,
		$Area2D/PickupAreaRight
	])

func _process(delta):
	match currentSide:
		0: #left
			changeLeft(true)
			changeRight(false)
		1: #right
			changeLeft(false)
			changeRight(true)
	pass

func _physics_process(delta):
	if not Engine.is_editor_hint():
		# Code to execute when in game.
		if not is_on_floor() && not held:
			velocity.y += gravity * delta
		move_and_slide()

func changeLeft(state):
	for node in leftElement:
		if state:
			node.show()
			node.process_mode = Node.PROCESS_MODE_INHERIT
			if not held:
				$LeftSizeCollisions.disabled = !state;
		else:
			node.hide()
			node.process_mode = Node.PROCESS_MODE_DISABLED
			$LeftSizeCollisions.disabled = !state;

func changeRight(state):
	for node in rightElement:
		if state:
			node.show()
			node.process_mode = Node.PROCESS_MODE_INHERIT
			if not held:
				$RightSizeCollisions.disabled = !state;
		else:
			node.hide()
			node.process_mode = Node.PROCESS_MODE_DISABLED
			$RightSizeCollisions.disabled = !state;

func setSide(side):
	currentSide = side
	
func setCollisions(state):
	$LeftSizeCollisions.disabled = !state; #cause is inverted
	$RightSizeCollisions.disabled = !state; #cause is inverted
