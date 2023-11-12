extends Node2D
class_name SenderComponent

@export var father : Node2D
var receivers : Array[ReceiverComponent]

# Called when the node enters the scene tree for the first time.
func _ready():
	if father != null:
		for node in father.receivers:
			if node.has_node("ReceiverComponent"):
				var receiver = node.get_node("ReceiverComponent")
				addReceiver(receiver)
	
	pass # Replace with function body.

func addReceiver(item):
	receivers.append(item)

func setReceivers(list: Array[ReceiverComponent]):
	if list != null and list.size() > 0:
		receivers = list

# Called every frame. 'delta' is the elapsed time since the previous frame.
func activate():
	for receiver in receivers:
		receiver.on_trigger()
	pass

func present(value):
	for receiver in receivers:
		receiver.toggleEnable(value)
	
