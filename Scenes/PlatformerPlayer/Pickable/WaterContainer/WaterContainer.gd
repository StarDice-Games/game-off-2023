extends CharacterBody2D
class_name WaterContainer

@export var side = 0

@export_category("Audio")
@export var wateringSmall : AudioStream
@export var wateringBig : AudioStream
@export var timeBeforeLoop : float = -1

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var canPlaySound = true
var animStarted = false

var lastAnimation = ""

@export var sprinkleOffset_big = 10
@export var sprinkleOffset_small = 10

@onready var soundPlayer = $AudioStreamPlayer

func _ready():
#	$Sprinkle.disabled = true
	$Sprinkle.hide()

func spreadWater():
#	$Sprinkle.disabled = false
	$Sprinkle.show()
	if $PickupComponent.activeSprite != null:
		match $PickupComponent.activeSprite.flip_h:
			true:
				$Sprinkle.scale.x = -1
			false:
				$Sprinkle.scale.x = 1
		match $PickupComponent.currentSide:
			1:
				playSound(wateringBig)
				$Sprinkle/Sprinkle_right.disabled = false
				$Sprinkle/Sprinkle_left.disabled = false
			0:
				playSound(wateringSmall)
				$Sprinkle/Sprinkle_right.disabled = false
				$Sprinkle/Sprinkle_left.disabled = false

func stopWater():
#	$Sprinkle.disabled = true
	$Sprinkle.hide()
	
func getAnimation():
	if $PickupComponent.currentSide == 0: #small side
		if $PickupComponent.activeSprite.flip_h:
			return "rotate_flip"
		else:
			#$Sprinkle.position.x = 1
			return "rotate"
	else:
		if $PickupComponent.activeSprite.flip_h:
			return "rotate"
		else:
			return "rotate_flip"

func _physics_process(delta):
	
	if Global.sfxMuted:
		soundPlayer.stream_paused = true
	else:
		soundPlayer.stream_paused = false
	
	if $PickupComponent.held:
		spreadWater()
		#TEST KEVIN ANIMAZIONE 	
		var anim = getAnimation()
		if anim != lastAnimation:
			$AnimationPlayer.play(anim);
			lastAnimation = anim
#			animStarted = true
			
	else:
		stopWater()
		soundPlayer.stop()
		canPlaySound = true
	#TEST KEVIN ANIMAZIONE 	
		$AnimationPlayer.play("RESET");
		lastAnimation = ""
		
		
	# Add the gravity.
	if not is_on_floor() and not $PickupComponent.held:
		velocity.y += gravity * delta
	move_and_slide()

func playSound(sound):
	if sound != null and canPlaySound:
		var timerTime = sound.get_length()
		if timeBeforeLoop > 0:
			timerTime = timeBeforeLoop
		canPlaySound = false
		
		soundPlayer.stream = sound
		soundPlayer.play()
		
#		AudioManager.play(sound)
		$stopMusic.start(timerTime)


func _on_stop_music_timeout():
	canPlaySound = true
	pass # Replace with function body.
