extends StaticBody2D

@export var maxKeys : int
@export var goalNumber : int
@export var indicatorScene : PackedScene

var keyCollected = 0
var isOpen = false

var indicators : Array[Node2D]

# Called when the node enters the scene tree for the first time.
func _ready():
	$Goal.goalNumber = goalNumber
	$Goal.active = false
	Global.setGoal(goalNumber, $Goal)
	
	if maxKeys > 0 and indicatorScene != null:
		for i in range(0, maxKeys):
			var indicator = indicatorScene.instantiate()
			indicator.position.x = $IndicatorStart.position.x + (i*32)
			indicator.unlock(true)
			indicators.append(indicator) 
			add_child(indicator)
			
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if keyCollected >= maxKeys and not isOpen:
		fullyOpen()
		
	#all indicator to false
	if indicators.size() > 0:
		for i in range(0, maxKeys):
			indicators[i].unlock(false)
		for i in range(0, keyCollected):
			indicators[i].unlock(true)
			
	pass

func fullyOpen():
	print("%s is open" % name)
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
