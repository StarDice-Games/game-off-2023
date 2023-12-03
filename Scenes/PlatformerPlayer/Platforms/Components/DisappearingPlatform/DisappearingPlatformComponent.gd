extends Area2D
class_name DisapearingPlatfromComponent

#@export var DisappearTime = 0.0
#@export var RespawnTime = 0.0
#@export var collider : CollisionShape2D

signal started_disappearing
signal finished_disappearing
signal started_respwaning
signal finished_respwaning

func setDisappearTimer(time):
	$Disappear.wait_time = time
	pass
func setRespawnTimer(time):
	$Disappear.wait_time = time
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	if body is PlatPlayer:
		started_disappearing.emit()
		$Disappear.start()
	pass # Replace with function body.


func _on_disappear_timeout():
	finished_disappearing.emit()
	started_respwaning.emit()
	$Respawn.start()
	pass # Replace with function body.


func _on_respawn_timeout():
	finished_respwaning.emit()
	pass # Replace with function body.
