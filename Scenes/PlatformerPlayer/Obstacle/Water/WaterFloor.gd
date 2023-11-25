extends StaticBody2D
class_name WaterFloor

@export_category("Audio")
@export var plopSound : AudioStream
@export var pipeSound : AudioStream

var mapSplash = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	AudioManager.play(pipeSound)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_area_entered(area):
	var key = area.get_parent().get_path().get_concatenated_names()
	if not mapSplash.has(key):
		AudioManager.play(plopSound)
		mapSplash[key] = area.name
	pass # Replace with function body.


func _on_area_2d_body_entered(body):
	var key = body.get_path().get_concatenated_names()
	if not mapSplash.has(key):
		AudioManager.play(plopSound)
		mapSplash[key] = body.name
	pass # Replace with function body.
