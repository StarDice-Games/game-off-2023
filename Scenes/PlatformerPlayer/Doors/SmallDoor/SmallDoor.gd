extends StaticBody2D

@export var maxKeys : int
@export var goalNumber : int
@export var indicatorScene : PackedScene
@export var indicatorOffset = 32

@export_category("Audio")
@export var doorOpen : AudioStream

var keyCollected = 0
var isOpen = false

var indicators : Array[Node2D]
var animStarted = false;

# Called when the node enters the scene tree for the first time.
func _ready():
	$Goal.goalNumber = goalNumber
	$Goal.active = false
	Global.setGoal(goalNumber, $Goal)
	$AnimationPlayer.play("RESET")
	
	if maxKeys > 0 and indicatorScene != null:
		for i in range(0, maxKeys):
			var indicator = indicatorScene.instantiate()
			indicator.position = $IndicatorStart.position
			indicator.position.y += i*indicatorOffset
			indicators.append(indicator) 
			add_child(indicator)
			
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if keyCollected >= maxKeys and not isOpen:
		fullyOpen()
		
	#all indicator to false
	if indicators.size() > 0 and Global.currentGameState == Global.GameState.IN_GAME:
		for i in range(0, maxKeys):
			indicators[i].unlock(false)
		for i in range(0, keyCollected):
			indicators[i].unlock(true)
	
	if $Goal.active:
		#$Sprite_Porta_Chiusa.hide()
		if animStarted == false:
			$AnimationPlayer.play("open")
			animStarted = true;
		#$Sprite_Porta_Aperta.show()
	else:
		$Sprite_Porta_Chiusa.show()
		#$Sprite_Porta_Aperta.hide()
	pass

func fullyOpen():
	isOpen = true
	$Goal.active = true
	AudioManager.play(doorOpen)
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
