extends StaticBody2D

@export var maxButton : int
@export var goalNumber : int
@export var indicatorScene : PackedScene
@export var indicatorOffset = 32

@export_category("Audio")
@export var doorOpen : AudioStream

var buttonActivated = 0
var isOpen = false
var indicators : Array[Node2D]

# Called when the node enters the scene tree for the first time.
func _ready():
	$Goal.goalNumber = goalNumber
	$Goal.active = false
	Global.setGoal(goalNumber, $Goal)
	
	if maxButton > 0 and indicatorScene != null:
		for i in range(0, maxButton):
			var indicator = indicatorScene.instantiate()
			indicator.position = $IndicatorStart.position
			indicator.position.y += i*indicatorOffset
#			indicator.unlock(true)
			indicators.append(indicator)
			add_child(indicator)
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if buttonActivated >= maxButton and not isOpen:
		fullyOpen()
	
	
	if indicators.size() > 0 and Global.currentGameState == Global.GameState.IN_GAME:
		#all indicator to false
		for i in range(0, maxButton):
			indicators[i].unlock(false)
		for i in range(0, buttonActivated):
			indicators[i].unlock(true)
			
	if $Goal.active:
		$Sprite_Porta_Chiusa.hide()
		#$Sprite_Porta_Aperta.show()
	else:
		$Sprite_Porta_Chiusa.show()
		#$Sprite_Porta_Aperta.hide()
	pass
	
	pass

func fullyOpen():
	print("Door is open")
	isOpen = true
	$Goal.active = true
	AudioManager.play(doorOpen)
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
