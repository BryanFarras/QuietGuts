extends Panel

@export var slot_scene: PackedScene

@onready var grid: = $NinePatchRect/GridContainer

var inventory: Inventory

func _enter_tree() -> void:
	InventoryEvent.inventory_initialized.connect(_on_inventory_initialized)
	InventoryEvent.inventory_updated.connect(_on_inventory_updated)

func _exit_tree() -> void:
	InventoryEvent.inventory_initialized.disconnect(_on_inventory_initialized)
	InventoryEvent.inventory_updated.disconnect(_on_inventory_updated)

func _ready():
	generate_slots()

func generate_slots():
	var backpack_slots = inventory.get_inventory_slots()

	for slot_data in backpack_slots:
		var slot_ui = slot_scene.instantiate()
		grid.add_child(slot_ui)
		slot_ui.set_slot(slot_data)

func update_slot():
	for slot_data in inventory.get_inventory_slots():
		for slot_ui in grid.get_children():
			if slot_ui.slot == slot_data:
				slot_ui.update_slot()

func _on_inventory_initialized(inv):
	inventory = inv

func _on_inventory_updated():
	update_slot()
