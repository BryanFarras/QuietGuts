extends Resource
class_name InventorySlot

var item: ItemData
var amount: int = 0

func is_empty():
	return item == null
