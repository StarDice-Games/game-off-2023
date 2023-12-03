extends CharacterBody2D
class_name MovingComponent

@export var speed = 0.1
@export var path : PathFollow2D
@export var active = true

var direction = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if Global.currentGameState != Global.GameState.IN_GAME:
		return
	if not active:
		return
	
	if path != null:
		var progress = path.progress_ratio
		if progress >= 1:
			direction *= -1
		if progress <= 0:
			direction *= -1
			
		path.progress += direction * speed * delta
	
	pass

func lerp(a, b, f):
	return a + f * (b - a);


func _on_receiver_component_triggered():
	active = !active
	pass # Replace with function body.


func _on_receiver_component_enabled():
	active = true
	pass # Replace with function body.


func _on_receiver_component_disabled():
	active = false
	pass # Replace with function body.
