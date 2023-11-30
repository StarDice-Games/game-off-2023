extends Control

signal close_credits

@onready var backButton = $Back

# Called when the node enters the scene tree for the first time.
func _ready():
	backButton.grab_focus()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_texture_button_pressed():
	close_credits.emit()
	pass # Replace with function body.


func _on_texture_button_focus_entered():
	Global.playSelectButton()
	pass # Replace with function body.
