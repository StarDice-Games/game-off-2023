extends Node2D

var simpleVar : int = 3
var array : Array = [1, 2, 3]
var scorep1 : int = 0;
var scorep2 : int = 0;

var activePlayer = 0; #Change with an enum to be player left = 0 or right=0

var players : Array[CharacterBody2D] = [null, null]
var goals : Array[Node2D]

@export var scaleFactor = Vector2(2, 2)
@export var scenes : Array[PackedScene]

var next_scene = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	
	next_scene %= scenes.size() #adapt the next_scene based on the total scenes
	pass # Replace with function body.

func setPlayer(number, player : CharacterBody2D):
	players[number] = player
	
func setGoal(number, goal : Node):
	goals.append(goal)
	
func getPlayer(index):
	return players[index]

func goalIsAchieved(goal):
	if goal == null :
		return false
		
	return goal.achieved

enum Scaling {
	INCREASE,
	DECREASE
}

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if Input.is_action_just_pressed("SwapPickable") :
		pass
			
	#Check if the level is complete
	var levelComplete = goals.all(goalIsAchieved)
	
#	if levelComplete:
#		print("Level is complete !!!", scenes.size())
##		if next_scene + 1 < scenes.size() :
#		if scenes[next_scene] != null:
#			get_tree().change_scene_to_packed(scenes[next_scene])
#			next_scene += 1
#			next_scene %= scenes.size()
			
	
	if Input.is_action_just_pressed("ResetLevel"):
		if next_scene == 0:
			next_scene = scenes.size()
		
		get_tree().change_scene_to_packed(scenes[next_scene - 1])
	pass
