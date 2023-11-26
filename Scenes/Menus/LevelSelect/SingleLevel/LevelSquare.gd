extends TextureButton
class_name LevelSquare

@export var levelRes : LevelResourceBase

@onready var icon : TextureRect = $icon
@onready var complete : TextureRect = $tickComplete
@onready var levelName : Label = $Label

signal level_selected(res)
signal on_focus


# Called when the node enters the scene tree for the first time.
func _ready():
	
	if levelRes != null:
		icon.texture = levelRes.icon
		levelName.text = levelRes.name
		complete.hide()
		if Global.isLevelComplete(levelRes.name):
			complete.show()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_border_focus_entered():
	on_focus.emit()
	pass # Replace with function body.


func _on_border_toggled(button_pressed):
	level_selected.emit(levelRes)
	pass # Replace with function body.


func _on_pressed():
	level_selected.emit(levelRes)
	pass # Replace with function body.
