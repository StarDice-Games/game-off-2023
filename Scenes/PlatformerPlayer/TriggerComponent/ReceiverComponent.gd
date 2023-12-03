extends Node2D
class_name ReceiverComponent

signal triggered
signal enabled
signal disabled

#@export var triggerNode : Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
#	if triggerNode != null:
#		triggerNode.connect("on_activate", on_trigger)
	pass # Replace with function body.

func on_trigger():
	triggered.emit()

func toggleEnable(state):
	if state :
		enabled.emit()
	else:
		disabled.emit()
