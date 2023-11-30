extends Node2D

@export var unlocked = false

@export_category("Audio")
@export var sound : AudioStream

var alreadyUnlocked = false

func unlock(state):
	unlocked = state
	if alreadyUnlocked == false and state:
		AudioManager.play(sound)
		alreadyUnlocked = true
	
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
