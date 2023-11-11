extends StaticBody2D

@export var maxButton : int
@export var goalNumber : int

var buttonActivated = 0
var isOpen = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$Goal.goalNumber = goalNumber
	$Goal.active = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if buttonActivated >= maxButton and not isOpen:
		fullyOpen()
	pass

func fullyOpen():
	print("Door is open")
	$CollisionShape2D.disabled = true
	$CollisionShape2D.process_mode = Node.PROCESS_MODE_DISABLED
	
	$Goal.active = true
	pass

func fullyClosed():
	$CollisionShape2D.disabled = false
	$CollisionShape2D.process_mode = Node.PROCESS_MODE_INHERIT
	$Goal.active = false
	pass


func _on_receiver_component_triggered():
	buttonActivated += 1
	pass # Replace with function body.


func _on_goal_body_entered(body):
	if body is PlatPlayer:
		$Goal.achieved = true
	pass # Replace with function body.


func _on_goal_body_exited(body):
	$Goal.achieved = false
	pass # Replace with function body.
