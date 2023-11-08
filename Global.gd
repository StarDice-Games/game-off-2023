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

enum GameState {
	MAIN_MENU,
	PAUSE,
	LEVEL_SELECT,
	IN_GAME
}

enum Scaling {
	INCREASE,
	DECREASE
}

var currentGameState = GameState.MAIN_MENU

# Called when the node enters the scene tree for the first time.
func _ready():	
	next_scene %= scenes.size() #adapt the next_scene based on the total scenes
	print("Global ready")
	toggleNode($MainMenu, true)
	$MainMenu.connect("exit_pressed", _on_main_menu_exit_pressed)
	$MainMenu.connect("new_game_pressed", _on_main_menu_new_game_pressed)
	pass # Replace with function body.

func setPlayer(number, player : CharacterBody2D):
	players[number] = player
	#also connect the died event
	players[number].connect("died", onPlayerDeath)
	
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
	if goal == null :
		return false
		
	return goal.achieved 

func transferPickable(starting, receiver, scaling : Scaling):
	#do not transfer if the other player has an item
	if receiver.pickedItem != null:
		return
	
#	the picket item is changed and transfered
#	now the picked item need to call this on the parent node
	var toTransfer : Node2D = starting.pickedItem
#	var parent = toTransfer.get_parent()
	if toTransfer != null:
		if scaling == Scaling.INCREASE: #toRightSide
			toTransfer.setSide(1)
		elif scaling == Scaling.DECREASE: #toLeftSide
			toTransfer.setSide(0)
		
		receiver.pickupItem(toTransfer)
		starting.dropItem()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	match currentGameState:
		GameState.MAIN_MENU:
			processMainMenu(delta)
			pass
		GameState.PAUSE:
			processPause(delta)
			pass
		GameState.LEVEL_SELECT:
			pass
		GameState.IN_GAME:
			processGame(delta)
			pass
#	

func processGame(delta):
#	if Input.is_action_just_pressed("ChangePlayer") :
#		for player in players:
#			if player == null:
#				continue
#			player.velocity = Vector2.ZERO
#		changeActivePlayer()
	
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
		players[activePlayer].velocity = Vector2.ZERO
		changeActivePlayer()
	
	#Check if the level is complete
	var levelComplete = goals.all(goalIsAchieved)
	
	if levelComplete:
		print("Level is complete !!!", scenes.size())
#		if next_scene + 1 < scenes.size() :
		if scenes[next_scene] != null:
			get_tree().change_scene_to_packed(scenes[next_scene])
			next_scene += 1
			next_scene %= scenes.size()
			
	#TODO remove this
	if Input.is_action_just_pressed("ChangeLevelDebug"):
		get_tree().change_scene_to_packed(scenes[next_scene])

	if Input.is_action_just_pressed("ResetLevel"):
		get_tree().reload_current_scene()
	pass
	pass

func processMainMenu(delta):
	#not sure at the moment	
	pass

func processPause(delta):
	pass

func processLevelSelect(delta):
	pass

func toggleNode(node, state):
	if state:
		node.show()
		node.process_mode = PROCESS_MODE_INHERIT
	else:
		node.hide()
		node.process_mode = PROCESS_MODE_DISABLED

func onPlayerDeath():
	print("Player Died")
	get_tree().reload_current_scene()


func _on_main_menu_exit_pressed():
	print("Quit the game")
	get_tree().quit()
	pass # Replace with function body.

func _on_main_menu_new_game_pressed():
	print("Start the game")
	#hide the menu
	toggleNode($MainMenu, false)
	#change the status
	currentGameState = GameState.IN_GAME
	#load the first scene
	if scenes.size() > 0:
		get_tree().change_scene_to_packed(scenes.front())
	pass # Replace with function body.
