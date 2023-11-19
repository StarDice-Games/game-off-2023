extends StaticBody2D

@export var maxKeys : int
@export var goalNumber : int

var keyCollected = 0
var isOpen = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$Goal.goalNumber = goalNumber
	$Goal.active = false
	Global.setGoal(goalNumber, $Goal)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if keyCollected >= maxKeys and not isOpen:
		fullyOpen()
	pass

func fullyOpen():
#	$CollisionShape2D.disabled = true
#	$CollisionShape2D.process_mode = Node.PROCESS_MODE_DISABLED
	
	$Goal.active = true
	pass

func fullyClosed():
#	$CollisionShape2D.disabled = false
#	$CollisionShape2D.process_mode = Node.PROCESS_MODE_INHERIT
	$Goal.active = false
	pass


func _on_receiver_component_triggered():
	keyCollected += 1
	pass # Replace with function body.


func _on_goal_body_entered(body):
	print("Goal enter")
	if $Goal.active:
		if body is PlatPlayer:
			$Goal.achieved = true
	pass # Replace with function body.


func _on_goal_body_exited(body):
	print("Goal exit")
	$Goal.achieved = false
	pass # Replace with function body.
