extends Node2D

@export var goalNumber = 0

var achieved = false

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.setGoal(goalNumber, self)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_area_entered(area):
	print("Goals Area Entered %s" % area.name)
	var rootNode = area.get_parent()
	if rootNode != null :
		for group in rootNode.get_groups():
			print("root node %s" % rootNode.name)
			if group == "Players":
				var player = Global.getPlayer(goalNumber)
				if rootNode.name == player.name:
					achieved = true
	pass # Replace with function body.


func _on_area_2d_area_exited(area):
	achieved = false # Non può essere completo se il giocatore non c'è dentro
	pass # Replace with function body.
