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


#func _on_area_2d_area_entered(area):
#	print("Goals Area Entered %s" % area.name)
#	var rootNode = area.get_parent()
#	if rootNode != null :
#		for group in rootNode.get_groups():
#			print("root node %s" % rootNode.name)
#			if group == "Players":
#				var player = Global.getPlayer(goalNumber)
#				if rootNode.name == player.name:
#					achieved = true
#	pass # Replace with function body.
#
#
#func _on_area_2d_area_exited(area):
#	achieved = false # Non può essere completo se il giocatore non c'è dentro
#	pass # Replace with function body.



#I want to chek the player body for now
#func _on_area_2d_body_entered(body):
#
#	pass # Replace with function body.
#
#
#func _on_area_2d_body_exited(body):
#	achieved = false # The player need to be in there
#	pass # Replace with function body.

#Body in this case is the player directly, cause we do not check the Area anymore
func _on_area_2d_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	print("Goals Body shape Entered %s" % body.name)
	var rootNode = body
	if rootNode != null :
		for group in rootNode.get_groups():
			print("root node %s" % rootNode.name)
			if group == "Players":
				var player = Global.getPlayer(goalNumber)
				if rootNode.name == player.name:
					achieved = true
	pass # Replace with function body.


func _on_area_2d_body_shape_exited(body_rid, body, body_shape_index, local_shape_index):
	achieved = false # The player need to be in there
	pass # Replace with function body.
