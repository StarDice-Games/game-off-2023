extends Control

signal end_splash

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("Splash")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func endSpashScreen():
	end_splash.emit()
