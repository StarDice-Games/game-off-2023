extends Node2D
class_name SenderComponent

var receivers : Array[ReceiverComponent]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func addReceiver(item):
	receivers.append(item)

func setReceivers(list: Array[ReceiverComponent]):
	receivers = list

# Called every frame. 'delta' is the elapsed time since the previous frame.
func activate():
	for receiver in receivers:
		receiver.on_trigger()
	pass

func present(value):
	for receiver in receivers:
		receiver.toggleEnable(value)
	
