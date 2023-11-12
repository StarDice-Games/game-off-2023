extends Area2D
class_name PlantVase

@export var receivers : Array[Node2D]
var active = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_entered(area):
	for group in area.get_groups():
		match group:
			"Water":
				if active == false:
					$SenderComponent.activate()
					active = true
	pass # Replace with function body.
