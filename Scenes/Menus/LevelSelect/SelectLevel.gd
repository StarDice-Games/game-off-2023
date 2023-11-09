extends Control
class_name SelectLevel
#@onready var itemListNode

var levelList : Array[LevelResource]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func setItems(itemList : Array[LevelResource]):	
	for item in itemList:
		$ItemList.add_item(item.name, item.icon)
		levelList.append(item)
	pass


func _on_item_list_item_clicked(index, at_position, mouse_button_index):
	print("Item clicked:", index, "-", levelList[index].name)
	pass # Replace with function body.


func _on_item_list_item_selected(index):
	print("Item selected:", index, "-", levelList[index].name)
	pass # Replace with function body.
