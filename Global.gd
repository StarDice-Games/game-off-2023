extends Node2D

var simpleVar : int = 3
var array : Array = [1, 2, 3]
var scorep1 : int = 0;
var scorep2 : int = 0;

var activePlayer = 0; #Change with an enum to be player left = 0 or right=0

var players : Array[CharacterBody2D] = [null, null]
var goals : Array[Node2D] = [null, null]

@export var scaleFactor = Vector2(2, 2)
@export var scenes : Array[PackedScene]

var next_scene = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	
	#Get a reference to the players in the level so i can swap the objects between them
	#Use groups ? or direct ? Let's try directly 
	pass # Replace with function body.

func setPlayer(number, player : CharacterBody2D):
	players[number] = player
	
func setGoal(number, goal : Node):
	goals[number] = goal
	
func getPlayer(index):
	return players[index]

func changeActivePlayer():
	match activePlayer:
			0 : 
				activePlayer = 1
			1 : 
				activePlayer = 0
				
func setActivePlayer(number):
	activePlayer = number

func goalIsAchieved(goal):
	return goal.achieved

enum Scaling {
	INCREASE,
	DECREASE
}
	
func transferPickable(starting, receiver, scaling : Scaling):
	#do not transfer if the other player has an item
	if receiver.pickedItem != null:
		return
	
#					the picket item is changed and transfered
	var  toTransfer : CharacterBody2D = starting.pickedItem
	if toTransfer != null:
		if scaling == Scaling.INCREASE:
			toTransfer.scale *= scaleFactor
		elif scaling == Scaling.DECREASE:
			toTransfer.scale /= scaleFactor
		
		receiver.pickupItem(toTransfer)
		starting.dropItem()
		changeActivePlayer()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if Input.is_action_just_pressed("ChangePlayer") :
		changeActivePlayer()
	
	if Input.is_action_just_pressed("ChangePlayerLeft") :
		setActivePlayer(0)
	
	if Input.is_action_just_pressed("ChangePlayerRight") :
		setActivePlayer(1)
	
	if Input.is_action_just_pressed("SwapPickable") :
		match activePlayer: #TODO move this in a function, to remove duplicate code
			0 :
				if not players[0] == null:
					var startingPlayer = players[0]
					var receivingPlayer = players[1]
					
					transferPickable(startingPlayer, receivingPlayer, Scaling.INCREASE)
			1 :
				if not players[1] == null:
					var startingPlayer = players[1]
					var receivingPlayer = players[0]
					
					transferPickable(startingPlayer, receivingPlayer, Scaling.DECREASE)
	
	#Check if the level is complete
	var levelComplete = goals.all(goalIsAchieved)
	
	if levelComplete:
		print("Level is complete !!!")
		get_tree().change_scene_to_packed(scenes[next_scene])
		next_scene += 1
		next_scene %= scenes.size()
			
	#TODO remove this
	if Input.is_action_just_pressed("ChangeLevelDebug"):
		get_tree().change_scene_to_packed(scenes[next_scene])

	if Input.is_action_just_pressed("ResetLevel"):
		if next_scene == 0:
			next_scene = scenes.size()
		
		get_tree().change_scene_to_packed(scenes[next_scene - 1])
	pass
