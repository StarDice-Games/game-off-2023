extends StaticBody2D

@export var breakSpeed : float = 10 
@export_category("Audio")
@export var breakSound : AudioStream


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _physics_process(delta):
#	var collision = get_last_slide_collision()
#	var collider = collision.get_collider()
#	if collider is Ball:
#		print("Death ", collision.get_collider().name)
	pass


func _on_area_2d_body_entered(body):
#	if body is Ball:
#		get_tree().queue_delete(self)
	for group in body.get_groups():
		if group == "BreaksWalls":
			if body is RigidBody2D: 
				var velLenght = body.linear_velocity.length()
				if velLenght > breakSpeed:
					$AnimatedSprite2D.play("default")
					$AnimationPlayer.play("DisableCollider")
					AudioManager.play(breakSound)
			#get_tree().queue_delete(self)
	pass # Replace with function body.


func _on_area_2d_area_entered(area):
	print("%s collide %s" % name, area.name)			
	pass # Replace with function body.
