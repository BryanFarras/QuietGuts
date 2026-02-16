extends Node
class_name Inventory

signal inventory_updated

var items := {}

func _ready():
	InventoryEvent.add_item_to_inventory.connect(Callable(self, "add_item"))
	InventoryEvent.remove_item_from_inventory.connect(Callable(self, "remove_item"))

func add_item(item_type: ResourceBase.ResourceType, amount: int = 1):
	if items.has(item_type):
		items[item_type] += amount
	else:
		items[item_type] = amount
	
	InventoryEvent.inventory_updated.emit()

func remove_item(item_type: ResourceBase.ResourceType, amount: int = 1):
	if not items.has(item_type):
		return
	
	items[item_type] -= amount
	
	if items[item_type] <= 0:
		items.erase(item_type)
	
	InventoryEvent.inventory_updated.emit()

func get_amount(item_type: ResourceBase.ResourceType) -> int:
	return items.get(item_type, 0)
