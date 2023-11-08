extends Control
class_name PauseMenu

signal on_resume_pressed
signal on_restart_pressed
signal on_exit_pressed

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_resume_pressed():
	print("Resume pressed")
	on_resume_pressed.emit()
	pass # Replace with function body.


func _on_restart_pressed():
	print("Restart pressed")
	on_restart_pressed.emit()
	pass # Replace with function body.


func _on_exit_pressed():
	print("Exit pressed")
	on_exit_pressed.emit()
	pass # Replace with function body.
