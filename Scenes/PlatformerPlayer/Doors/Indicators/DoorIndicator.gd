@tool
extends Node2D

@export var unlocked = false

func unlock(state):
	unlocked = state
	
func _ready():
	if unlocked:
		$Open.show()
		$Closed.hide()
	else:
		$Open.hide()
		$Closed.show()
	
func _process(delta):
	if unlocked:
		$Open.show()
		$Closed.hide()
	else:
		$Open.hide()
		$Closed.show()
