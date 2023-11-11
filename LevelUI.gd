extends Control

@export var goalIndicator : Array[ColorRect]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if Global.goals[0] != null:
		$ColorRect.modulate = Color.RED
	if Global.goals[0].achieved == true:
		$ColorRect.modulate = Color.GREEN
	
	if Global.goals[1] != null:
		$ColorRect2.modulate = Color.RED
	if Global.goals[1].achieved == true:
		$ColorRect2.modulate = Color.GREEN
	pass
