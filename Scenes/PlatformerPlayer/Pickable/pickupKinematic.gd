@tool
extends Node2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var held = false
@export var currentSide = 0

func _process(delta):
	match currentSide:
		0: #left
			$LeftSide.process_mode = Node.PROCESS_MODE_INHERIT
			$LeftSide.show()
			
			$RightSide.process_mode = Node.PROCESS_MODE_DISABLED
			$RightSide.hide()
		1: #right
			$RightSide.process_mode = Node.PROCESS_MODE_INHERIT
			$RightSide.show()
			
			$LeftSide.process_mode = Node.PROCESS_MODE_DISABLED
			$LeftSide.hide()
	pass

func setSide(side):
	currentSide = side
	
func setCollisions(state):
	$LeftSide/CollisionShape2D.disabled = !state; #cause is inverted
	$RightSide/RightCollision.disabled = !state; #cause is inverted
