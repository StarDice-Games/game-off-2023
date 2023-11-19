extends Area2D
class_name KeyComponent

@export var receivers : Array[Node2D]
@onready var senderComp : SenderComponent = $SenderComponent

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
	print("%s _on_body_entered:%s" % name, body.name)
	senderComp.activate()
	get_tree().queue_delete(self)
	pass # Replace with function body.
