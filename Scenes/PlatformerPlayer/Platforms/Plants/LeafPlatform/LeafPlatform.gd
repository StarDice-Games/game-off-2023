extends StaticBody2D

@export var active = false

# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	match active:
		true:
			$CollisionPolygon2D.disabled = false
		false:
			$CollisionPolygon2D.disabled = true
	pass

func finishedGrowing():
	active = true

func _on_receiver_component_triggered():
	show()
	$AnimationPlayer.play("activated")
	pass # Replace with function body.
