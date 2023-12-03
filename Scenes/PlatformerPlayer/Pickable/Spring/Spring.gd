@tool
extends CharacterBody2D
class_name Spring

@export var side = 0
@export var JUMP_FORCE = 400

@export_category("Audio")
@export var jumpSoundBig : AudioStream
@export var jumpSoundSmall : AudioStream
#@export var timeBetweenLoops = 1

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var canPlaySound = true

@onready var animator : AnimationPlayer = $AnimationPlayer

func _ready():
	$PickupComponent.setSide(side)

func _process(delta):
	if Engine.is_editor_hint():
		$PickupComponent.setSide(side)

func _physics_process(delta):
	
	if Engine.is_editor_hint():
		return
	# Add the gravity.
	if not is_on_floor() and not $PickupComponent.held:
		velocity.y += gravity * delta
	
	move_and_slide()

func ApplyForceToPlayer(collider, size):
	if collider is PlatPlayer:
#		var pos = size.position
#		var siz = size.size
#		var height = (collider.position.y - size.position.y) + size.size.y
		
		if $PickupComponent.held == false:
			collider.velocity.y = JUMP_FORCE
			playSound(jumpSoundSmall)
			animator.play("push")

func ApplyForceToItems(collider):
	if collider is PlatPlayer:
		return
	if collider is Spring:
		return
	
	for group in collider.get_groups():
		if group == "Pickable":
			if $PickupComponent.held == false:
				if collider is RigidBody2D:
					collider.apply_impulse(Vector2.UP * JUMP_FORCE)
				else:
					collider.velocity.y = JUMP_FORCE
				playSound(jumpSoundBig)
				animator.play("push")
		


func _on_pickup_component_body_entered(body):
	if body != null:
		match $PickupComponent.currentSide:
			0:
				ApplyForceToPlayer(body, null)
				
			1:
				ApplyForceToItems(body)
	pass # Replace with function body.

func playSound(sound):
	if sound != null and canPlaySound:
		canPlaySound = false
		AudioManager.play(sound)
		$stopMusic.start(sound.get_length())


func _on_stop_music_timeout():
	canPlaySound = true
	pass # Replace with function body.
