extends Panel

@export var slot_scene: PackedScene

@onready var slots: = $NinePatchRect/GridContainer.get_children()

func _ready():
	InventoryEvent.inventory_updated.connect(_on_inventory_updated)

func _on_inventory_updated(inv):
	for i in min(inv.slots.size(), slots.size()):
		slots[i].update_slot(inv.slots[i])
