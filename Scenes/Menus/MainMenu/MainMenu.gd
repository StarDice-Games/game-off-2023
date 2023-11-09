extends Control
class_name MainMenu

signal new_game_pressed
signal select_level_ressed
signal exit_pressed

# Called when the node enters the scene tree for the first time.
func _ready():
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
