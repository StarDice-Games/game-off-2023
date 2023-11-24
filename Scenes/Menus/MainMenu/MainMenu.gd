extends Control
class_name MainMenu

signal new_game_pressed
signal select_level_ressed
signal exit_pressed

# Called when the node enters the scene tree for the first time.
func _ready():
	$NewGame.grab_focus()
	$ColorRect/Music.button_pressed = !Global.musicMuted
	$ColorRect2/Sounds.button_pressed = !Global.sfxMuted
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):	
	pass


func _on_new_game_pressed():
	print("Start new game")
	new_game_pressed.emit()
	pass # Replace with function body.


func _on_level_select_pressed():
	print("Open select level TBD")
	select_level_ressed.emit()
	pass # Replace with function body.


func _on_exit_pressed():
	exit_pressed.emit()
	print("Exit from the game")
	pass # Replace with function body.

func _on_draw():
	print("main menu Become visible")
	$NewGame.grab_focus()
	pass # Replace with function body.


func _on_sounds_pressed():
	pass # Replace with function body.


func _on_music_toggled(button_pressed):
	Global.musicMuted = !button_pressed
	pass # Replace with function body.


func _on_sounds_toggled(button_pressed):
	Global.sfxMuted = !button_pressed
	pass # Replace with function body.
