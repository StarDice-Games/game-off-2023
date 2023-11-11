@tool
extends Area2D
class_name PickupComponent

var held = false

@export var currentSide = 0

@export var leftElement : Array[Node2D] = []
@export var rightElement : Array[Node2D] = []

#TODO maybe separate the visual with the pickable option
@export var collisionLeft : CollisionShape2D
@export var collisionRight : CollisionShape2D

func _ready():
	pass

func _process(delta):
	match currentSide:
		0: #left
			changeLeft(true)
			changeRight(false)
		1: #right
			changeLeft(false)
			changeRight(true)
	pass

func changeLeft(state):
	for node in leftElement:
		if node == null:
			continue
		if state:
			if not Engine.is_editor_hint():
				if not held and collisionLeft != null:
					collisionLeft.disabled = !state;
			node.show()
			node.process_mode = Node.PROCESS_MODE_INHERIT
		else:
			node.hide()
			node.process_mode = Node.PROCESS_MODE_DISABLED
			if collisionLeft != null:
				collisionLeft.disabled = !state;

func changeRight(state):
	for node in rightElement:
		if node == null:
			continue
		if state:
			node.show()
			node.process_mode = Node.PROCESS_MODE_INHERIT
			if not Engine.is_editor_hint():
				if not held and collisionRight != null:
					collisionRight.disabled = !state;
		else:
			node.hide()
			node.process_mode = Node.PROCESS_MODE_DISABLED
			if collisionRight != null:
				collisionRight.disabled = !state;

func setSide(side):
	currentSide = side
	
func setCollisions(state):
	if collisionLeft != null: 
		collisionLeft.disabled = !state; #cause is inverted
	if collisionRight != null:
		collisionRight.disabled = !state; #cause is inverted

func setPosition(position):
	get_parent().position = position
