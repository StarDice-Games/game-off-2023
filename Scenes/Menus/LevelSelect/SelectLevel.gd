extends Control
class_name SelectLevel
#@onready var itemListNode

var levelList : Array[LevelResourceBase]

signal on_level_selected(res)
signal on_back

var currentSelectedLevel = null

@onready var focusButton : Control = $LevelSquare

# Called when the node enters the scene tree for the first time.
func _ready():
	focusButton.grab_focus()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func setItems(itemList : Array[LevelResourceBase]):	
#	for item in itemList:
#		$ItemList.add_item(item.name, item.icon)
#		levelList.append(item)
	
#	$ItemList.grab_focus()
	pass


func _on_item_list_item_clicked(index, at_position, mouse_button_index):
	print("Item clicked:", index, "-", levelList[index].name)	
	on_level_selected.emit(index)
	pass # Replace with function body.


func _on_item_list_item_selected(index):
	print("Item selected:", index, "-", levelList[index].name)
	Global.playSelectButton()
	pass # Replace with function body.


func _on_back_pressed():
	on_back.emit()
	pass # Replace with function body.


func _on_item_list_item_activated(index):
	print("Item activated:", index, "-", levelList[index].name)	
	on_level_selected.emit(index)
	pass # Replace with function body.

func _on_button_focus():
	Global.playSelectButton()
	pass # Replace with function body.


func _on_level_square_level_selected(res):
	currentSelectedLevel = res
	print("Level selected:", res.name)
	pass # Replace with function body.


func _on_texture_button_pressed():
	if currentSelectedLevel != null:
		on_level_selected.emit(currentSelectedLevel)
	pass # Replace with function body.
