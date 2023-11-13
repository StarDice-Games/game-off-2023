@tool
extends Area2D
class_name PickupComponent

var held = false

@export var currentSide = 0

@export var father : Node2D 

@export var leftElement : Array[Node2D] = []
@export var rightElement : Array[Node2D] = []

#TODO maybe separate the visual with the pickable option
@export var collisionLeft : CollisionShape2D
@export var collisionRight : CollisionShape2D

var activeSprite : Sprite2D

func _ready():
	if father != null:
		currentSide = father.side
	pass

func _process(delta):
	if Engine.is_editor_hint() and father != null:
		currentSide = father.side
	
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
			if node is CollisionShape2D and not held:
				node.disabled = !state
			if node is Sprite2D:
				activeSprite = node
		else:
			node.hide()
			node.process_mode = Node.PROCESS_MODE_DISABLED
			if collisionLeft != null:
				collisionLeft.disabled = !state;
			if node is CollisionShape2D:
				node.disabled = !state
			if node is Sprite2D:
				activeSprite = null

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
			if node is CollisionShape2D and not held:
				node.disabled = !state
			if node is Sprite2D:
				activeSprite = node
		else:
			node.hide()
			node.process_mode = Node.PROCESS_MODE_DISABLED
			if collisionRight != null:
				collisionRight.disabled = !state;
			if node is CollisionShape2D:
				node.disabled = !state
			if node is Sprite2D:
				activeSprite = null

func setSide(side):
	currentSide = side
	
func setCollisions(state):
	if collisionLeft != null: 
		collisionLeft.disabled = !state; #cause is inverted
	if collisionRight != null:
		collisionRight.disabled = !state; #cause is inverted

func setPosition(position):
	get_parent().position = position

func setScale(scale):
	if activeSprite != null:
		activeSprite.flip_h = scale
