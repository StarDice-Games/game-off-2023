extends Control
class_name PauseMenu

signal on_resume_pressed
signal on_restart_pressed
signal on_exit_pressed

@onready var musicToggle = $Control/Music
@onready var soundToggle = $Control/Sounds

# Called when the node enters the scene tree for the first time.
func _ready():
	$Control/Resume.grab_focus()
	musicToggle.button_pressed = !Global.musicMuted
	soundToggle.button_pressed = !Global.sfxMuted
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


func _on_control_draw():
	$Control/Resume.grab_focus()
	musicToggle.button_pressed = !Global.musicMuted
	soundToggle.button_pressed = !Global.sfxMuted
	pass # Replace with function body.


func _on_music_toggled(button_pressed):
	Global.musicMuted = !button_pressed
	pass # Replace with function body.


func _on_sounds_toggled(button_pressed):
	Global.sfxMuted = !button_pressed
	pass # Replace with function body.

func _on_button_focus():
	Global.playSelectButton()
	pass # Replace with function body.
