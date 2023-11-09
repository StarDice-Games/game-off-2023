extends CharacterBody2D
class_name MovingComponent

@export var speed = 0.1
@export var path : PathFollow2D
@export var moved = 0.0
#var pos : Vector2
var direction = 1
var speedDiff = speed

# Called when the node enters the scene tree for the first time.
func _ready():
	var path2d = path.get_parent()
	if path2d is Path2D:
		var lenght = path2d.get_curve().get_baked_length()
		speedDiff = lenght / speed
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if Global.currentGameState != Global.GameState.IN_GAME:
		return
	
	var progress = path.progress_ratio
	if progress >= 1:
		direction *= -1
	if progress <= 0:
		direction *= -1
		
	path.progress += direction * speed * delta
	
	pass

func lerp(a, b, f):
	return a + f * (b - a);
