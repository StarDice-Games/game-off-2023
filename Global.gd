extends Node2D

var simpleVar : int = 3
var array : Array = [1, 2, 3]
var scorep1 : int = 0;
var scorep2 : int = 0;

var activePlayer = 0; #Change with an enum to be player left = 0 or right=0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if Input.is_action_just_pressed("ChangePlayer") :
		match activePlayer:
			0 : 
				activePlayer = 1
			1 : 
				activePlayer = 0 
	
	pass
