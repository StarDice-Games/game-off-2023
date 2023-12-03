extends StaticBody2D

@export var openingSpeed = 0.0
@export var OpeningAnimation : Animation 

# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func fullyOpen():
	hide()
	$CollisionShape2D.disabled = true
	$CollisionShape2D.process_mode = Node.PROCESS_MODE_DISABLED
	pass

func fullyClosed():
	$CollisionShape2D.disabled = false
	$CollisionShape2D.process_mode = Node.PROCESS_MODE_INHERIT
	pass
	
func _on_receiver_component_enabled():
	#open the door , play a little animation at the end remove the collider
	
	$AnimationPlayer.play("open")
	pass # Replace with function body.



func _on_receiver_component_disabled():
	show()
	$AnimationPlayer.play("close")
	pass # Replace with function body.
