@tool
extends Area2D
class_name PickupComponent

var held = false

@export var currentSide = 0

@export var father : Node2D 

@export var leftElement : Array[Node2D] = []
@export var rightElement : Array[Node2D] = []

#TODO maybe separate the visual with the pickable option
@export var collisionLeft : Node2D
@export var collisionRight : CollisionShape2D

@export_range(1, 200, 0.5) var flashTime = 1

var activeSprite : Sprite2D
var isFlashing = false
var timer = 0

func _ready():
	if father != null:
		currentSide = father.side
	pass
	
	if flashTime == null:
		flashTime = 1

func _process(delta):
	if Engine.is_editor_hint() and father != null:
		currentSide = father.side
	
	match currentSide:
		0: #left
			change(leftElement, true, collisionLeft)
			change(rightElement, false, collisionRight)
		1: #right
			change(leftElement, false, collisionLeft)
			change(rightElement, true, collisionRight)
	pass
	
	if isFlashing and activeSprite != null:
		if activeSprite.modulate.a == 1.0:
			activeSprite.modulate.a = 0.1
		else:
			activeSprite.modulate.a += 1 * delta
		
		if timer >= flashTime:
			activeSprite.modulate.a = 1.0
			isFlashing = false
			timer = 0
		else:
			timer += 1 * delta
				
func change(nodeList, isActive, collisionSide):
	for node in nodeList:
		if node == null:
			continue
		if isActive:
			if not Engine.is_editor_hint():
				if not held and collisionSide != null:
					collisionSide.disabled = !isActive;
			
			node.show()
			node.process_mode = Node.PROCESS_MODE_INHERIT
			
			if node is CollisionShape2D and not held:
				node.disabled = !isActive
			if node is Sprite2D:
				activeSprite = node
		else:
			node.hide()
			node.process_mode = Node.PROCESS_MODE_DISABLED
			if collisionSide != null:
				collisionSide.disabled = !isActive;
			if node is CollisionShape2D:
				node.disabled = !isActive
	

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

func highlight():
	isFlashing = true


func _on_flash_timer_timeout():
	isFlashing = false
	pass # Replace with function body.
