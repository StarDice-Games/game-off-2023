extends CharacterBody2D

@export var SPEED = 300

# Called when the node enters the scene tree for the first time.
func _ready():
	velocity.x = SPEED
	velocity.y = 50
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	var collision : KinematicCollision2D = move_and_collide(velocity * delta)
	if collision != null:
		print( "name:", collision.get_collider().name)
		velocity = velocity.bounce(collision.get_normal())
		
		match collision.get_collider().name:
			"GoalP1":
				Global.scorep2+=1
				print("We are number one!")
			"GoalP2":
				Global.scorep1+=1
				print("Two are better than one!")
	pass
	
#	move_and_slide()

