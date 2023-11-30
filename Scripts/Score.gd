extends Label

@export var player = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if player == 1 :
		text = "%d" % Global.scorep1
	else:
		text = "%d" % Global.scorep2
	pass
