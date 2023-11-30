extends StaticBody2D

@export_category("Audio")
@export var fireSound : AudioStream
@export var putOutSound : AudioStream

@onready var soundPlayer : AudioStreamPlayer = $AudioStreamPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play("default")
#	AudioManager.play(fireSound)
	
	soundPlayer.stream = fireSound
	soundPlayer.play()
	
	
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Global.sfxMuted:
		soundPlayer.stream_paused = true
	else:
		soundPlayer.stream_paused = false
	pass

func extinguish(node):
	for group in node.get_groups():
		if group == "Water":
			AudioManager.play(putOutSound)
			soundPlayer.stop()
			get_tree().queue_delete(self)

func _on_area_2d_area_entered(area):
	extinguish(area)
	pass # Replace with function body.


func _on_area_2d_body_entered(body):
	extinguish(body)
	pass # Replace with function body.
