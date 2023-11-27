extends Control
class_name MainMenu

signal new_game_pressed
signal select_level_ressed
signal exit_pressed
signal open_credits

@onready var buttonToFocus = $Control2/NewGame
@onready var musicToggle = $Control2/TextureMusic
@onready var sfxToggle = $Control2/TextureSounds

# Called when the node enters the scene tree for the first time.
func _ready():
	buttonToFocus.grab_focus()
	musicToggle.button_pressed = Global.musicMuted
	sfxToggle.button_pressed = Global.sfxMuted
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
	buttonToFocus.grab_focus()
	musicToggle.button_pressed = Global.musicMuted
	sfxToggle.button_pressed = Global.sfxMuted
	pass # Replace with function body.


func _on_music_toggled(button_pressed):
	Global.musicMuted = button_pressed
	pass # Replace with function body.


func _on_sounds_toggled(button_pressed):
	Global.sfxMuted = button_pressed
	pass # Replace with function body.


func _on_button_focus():
	Global.playSelectButton()
	pass # Replace with function body.
