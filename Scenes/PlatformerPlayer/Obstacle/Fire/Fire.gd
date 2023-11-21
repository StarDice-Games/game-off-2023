extends StaticBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play("default")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func extinguish(node):
	for group in node.get_groups():
		if group == "Water":
			get_tree().queue_delete(self)

func _on_area_2d_area_entered(area):
	extinguish(area)
	pass # Replace with function body.


func _on_area_2d_body_entered(body):
	extinguish(body)
	pass # Replace with function body.
