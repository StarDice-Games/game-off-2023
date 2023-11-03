extends Node2D

@export var speed = 600
var visibility = true;

# Called when the node enters the scene tree for the first time.
func _ready():
	print(Global.simpleVar)
	
	for ele in Global.array:
		print("Element %s" % ele)
		print("Element is {named}".format({"named":ele}))
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("ui_left"):
		position.x -= speed * delta
	if Input.is_action_pressed("ui_right"):
		position.x += speed * delta
	if Input.is_action_pressed("ui_up"):
		position.y -= speed * delta
	if Input.is_action_pressed("ui_down"):
		position.y += speed * delta
		
	if Input.is_action_just_pressed("Confirm"):
		var sprite2D = $Sprite2D
		visibility = !visibility
		sprite2D.visible = visibility
	pass


func _on_area_2d_area_entered(area):
	print("Area Entered %s" % area.name)
	var rootNode = area.get_parent()
	if rootNode != null:
		print("root node %s" % rootNode.name)
		rootNode.queue_free()
	
	pass # Replace with function body.
