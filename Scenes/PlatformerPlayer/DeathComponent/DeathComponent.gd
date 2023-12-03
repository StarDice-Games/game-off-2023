extends Area2D
class_name DeathComponent

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_body_entered(body):
	print("DeathComponent _on_body_entered endtered ", body.name)
	pass # Replace with function body.


func _on_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	print("DeathComponent _on_body_shape_entered endtered ", body.name)
	if body is PlatPlayer:
		body.playDeath()
	pass # Replace with function body.


func _on_area_entered(area):
	print("DeathComponent Area endtered ", area.name)
	pass # Replace with function body.
