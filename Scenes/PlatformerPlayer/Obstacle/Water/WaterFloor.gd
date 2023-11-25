extends StaticBody2D
class_name WaterFloor

@export_category("Audio")
@export var plopSound : AudioStream
@export var pipeSound : AudioStream

# Called when the node enters the scene tree for the first time.
func _ready():
	AudioManager.play(pipeSound)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_area_entered(area):
	AudioManager.play(plopSound)
	pass # Replace with function body.


func _on_area_2d_body_entered(body):
	AudioManager.play(plopSound)
	pass # Replace with function body.
