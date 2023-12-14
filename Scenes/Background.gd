extends Node2D

signal on_restart_pressed

# Called when the node enters the scene tree for the first time.
func _ready():
	$Gomma/AnimatedSprite2D.frame = 0
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Global.sfxMuted:
		$EraseSFX.volume_db=-80
	else:
		$EraseSFX.volume_db= 7.135
		
	if Input.is_action_pressed("ResetLevel"):
		if $EraseSFX.playing == false:
			$EraseSFX.play()

		if $Gomma/AnimatedSprite2D.frame == 9:
			Global.restartLevel()
		else:
			$Gomma/AnimatedSprite2D.play("default")
			$Gomma/AnimationPlayer.play("hold")

	if Input.is_action_just_released("ResetLevel"):
		$EraseSFX.stop()
		$Gomma/AnimatedSprite2D.play_backwards("default")
		$Gomma/AnimationPlayer.play_backwards("hold")
		
	pass
