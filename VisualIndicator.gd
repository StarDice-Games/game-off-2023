extends Control
#@export var Side = 0

@onready var leftSide = $Left
@onready var rightSide = $Right

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	visualIndicator()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	visualIndicator()
	
func visualIndicator():
	match Global.activePlayer:
		0:
			leftSide.hide()
			rightSide.show()
		1: 
			rightSide.hide()
			leftSide.show()
