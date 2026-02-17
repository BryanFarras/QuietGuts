extends Node
class_name Inventory

@export var slots: Array[InventorySlot]

func _ready():
	InventoryEvent.add_item_to_inventory.connect(add_item)


func add_item(item: ItemData, quantity: int = 1):
	print("Adding item: ", item.name, " x", quantity)

	# 1️⃣ Try stack first
	for slot in slots:
		if slot.item == null:
			continue
		if slot.item == item and slot.amount < item.max_stack:
			slot.amount += quantity
			InventoryEvent.inventory_updated.emit(self)
			return true

	# 2️⃣ Find empty slot
	for slot in slots:
		if slot.is_empty():
			slot.item = item
			slot.amount = quantity
			InventoryEvent.inventory_updated.emit(self)
			return true

	return false # inventory full
