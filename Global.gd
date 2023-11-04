extends Node2D

var simpleVar : int = 3
var array : Array = [1, 2, 3]
var scorep1 : int = 0;
var scorep2 : int = 0;

var activePlayer = 0; #Change with an enum to be player left = 0 or right=0

var players : Array[CharacterBody2D] = [null, null]

@export var scaleFactor = Vector2(2, 2)
@export var next_scene : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	
	#Get a reference to the players in the level so i can swap the objects between them
	#Use groups ? or direct ? Let's try directly 
	pass # Replace with function body.

func setPlayer(number, player : CharacterBody2D):
	players[number] = player

func changeActivePlayer():
	match activePlayer:
			0 : 
				activePlayer = 1
			1 : 
				activePlayer = 0
				
func setActivePlayer(number):
	activePlayer = number

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if Input.is_action_just_pressed("ChangePlayer") :
		changeActivePlayer()
	
	if Input.is_action_just_pressed("ChangePlayerLeft") :
		setActivePlayer(0)
	
	if Input.is_action_just_pressed("ChangePlayerRight") :
		setActivePlayer(1)
	
	if Input.is_action_just_pressed("SwapPickable") :
		match activePlayer:
			0 :
				if not players[0] == null:
					var startingPlayer = players[0]
					var receivingPlayer = players[1]
					
#					the picket item is changed and transfered
					var  toTransfer : CharacterBody2D = startingPlayer.pickedItem
					if toTransfer != null:
						toTransfer.scale = scaleFactor
						receivingPlayer.pickupItem(toTransfer)
						startingPlayer.dropItem()
						changeActivePlayer()
					
					print("Player 1 item", players[0].pickedItem)
					
			1 :
				if not players[1] == null:
					var startingPlayer = players[1]
					var receivingPlayer = players[0]
					
#					the picket item is changed and transfered
					var  toTransfer : CharacterBody2D = startingPlayer.pickedItem
					if toTransfer != null:
						toTransfer.scale = Vector2(1,1)
						receivingPlayer.pickupItem(toTransfer)
						startingPlayer.dropItem()
						changeActivePlayer()
	
	#TODO remove this
	if Input.is_action_just_pressed("ChangeLevelDebug"):
		get_tree().change_scene_to_packed(next_scene)
	pass
