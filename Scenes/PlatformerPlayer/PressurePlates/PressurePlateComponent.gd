extends Area2D
class_name PressurePlateComponent

@export var receivers : Array[Node2D]
@export_category("Audio")
@export var compressSound : AudioStream
@export var decompressSound : AudioStream

@onready var senderComp : SenderComponent = $SenderComponent
@onready var animator : AnimationPlayer = $AnimationPlayer

var numOfObject = 0;

# Called when the node enters the scene tree for the first time.
func _ready():
	
	if senderComp != null:
		for node in receivers:
			var receiverComp = node.get_node("ReceiverComponent")
			if receiverComp != null:
				print("%s - Register receiver %s" % name, receiverComp.name)
				senderComp.addReceiver(receiverComp)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	pass

func _on_area_entered(area):
	print("%s _on_area_entered:" % name)
#	senderComp.activate()
	pass # Replace with function body.

func _on_body_entered(body):
	print("%s _on_body_entered:" % name)
	senderComp.present(true)
	if numOfObject <= 0:
		animator.play("push")
		AudioManager.play(compressSound)
	numOfObject += 1
	pass # Replace with function body.

func _on_body_exited(body):
	print("%s _on_body_exited:" % name)
	numOfObject -= 1
	if numOfObject <= 0:
		senderComp.present(false)
		animator.play("release")
		AudioManager.play(decompressSound)
	pass # Replace with function body.

func _on_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	print("%s _on_body_shape_entered:" % name)
	pass # Replace with function body.



