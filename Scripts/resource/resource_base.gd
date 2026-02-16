extends Area2D
class_name ResourceBase

enum ResourceType {
	WOOD,
	STONE,
	IRON
}

@export var resource_type := ResourceType.WOOD
@export var amount := 1

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body):
	if body.is_in_group("Player"):
		InventoryEvent.add_item_to_inventory.emit(resource_type, amount)
		queue_free()
