extends Control
@export var Side = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	visualIndicator()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	visualIndicator()
	
func visualIndicator():
	if Global.activePlayer == Side :
		hide()
	else : 
		show()
