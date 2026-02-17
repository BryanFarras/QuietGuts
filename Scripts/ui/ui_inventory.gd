extends Control

@export var slot_scene: PackedScene

@onready var slots: = $NinePatchRect/GridContainer.get_children()

func _unhandled_input(event):
	if event.is_action_pressed("inventory"):
		visible = !visible

func _ready():
	InventoryEvent.inventory_updated.connect(_on_inventory_updated)

func _on_inventory_updated(inv):
	for i in min(inv.slots.size(), slots.size()):
		slots[i].update_slot(inv.slots[i])
