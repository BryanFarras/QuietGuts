extends Node
class_name Inventory

@export var slots: Array[SlotData] = []
@export var hotbar_size: int = 10

func _enter_tree() -> void:
	InventoryEvent.add_item_to_inventory.connect(add_item)
	InventoryEvent.remove_item_from_inventory.connect(remove_item)

func _exit_tree() -> void:
	InventoryEvent.add_item_to_inventory.disconnect(add_item)
	InventoryEvent.remove_item_from_inventory.disconnect(remove_item)

func _ready():
	InventoryEvent.inventory_initialized.emit(self)


func add_item(item: ItemData, quantity: int = 1):
	print("Adding item: ", item.name, " x", quantity)

	# 1️⃣ Try stack first
	for slot in slots:
		if slot.item == null:
			continue
		if slot.item == item and slot.amount < item.max_stack:
			slot.amount += quantity
			InventoryEvent.inventory_updated.emit()
			return true

	# 2️⃣ Find empty slot
	for slot in slots:
		if slot.is_empty():
			slot.item = item
			slot.amount = quantity
			InventoryEvent.inventory_updated.emit()
			return true

	return false # inventory full

func remove_item(item: ItemData, quantity: int):

	for slot in slots:
		if slot.item == item:
			var remove_amount = min(quantity, slot.amount)
			slot.amount -= remove_amount
			quantity -= remove_amount

			if slot.amount <= 0:
				slot.item = null

			if quantity <= 0:
				break

	InventoryEvent.inventory_updated.emit()

func get_item_amount(item: ItemData) -> int:
	var total := 0
	for slot in slots:
		if slot.item == item:
			total += slot.amount
	return total

func get_hotbar_slots():
	return slots.slice(0, hotbar_size)

func get_inventory_slots():
	return slots.slice(hotbar_size, slots.size())
