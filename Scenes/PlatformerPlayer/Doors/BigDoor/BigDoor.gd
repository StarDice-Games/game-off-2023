extends StaticBody2D

@export var maxButton : int
@export var goalNumber : int

var buttonActivated = 0
var isOpen = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$Goal.goalNumber = goalNumber
	$Goal.active = false
	Global.setGoal(goalNumber, $Goal)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if buttonActivated >= maxButton and not isOpen:
		fullyOpen()
	pass

func fullyOpen():
	$Goal.active = true
	pass

func fullyClosed():
	$Goal.active = false
	pass


func _on_receiver_component_triggered():
	buttonActivated += 1
	pass # Replace with function body.


func _on_goal_body_entered(body):
	print("Goal enter")
	if body is PlatPlayer and $Goal.active:
		$Goal.achieved = true
	pass # Replace with function body.


func _on_goal_body_exited(body):
	print("Goal exit")
	$Goal.achieved = false
	pass # Replace with function body.
