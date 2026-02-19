extends HBoxContainer

@export var slot_scene: PackedScene

var inventory: Inventory
var selected_index: int = 0

func _enter_tree() -> void:
	InventoryEvent.inventory_initialized.connect(_on_inventory_initialized)
	InventoryEvent.inventory_updated.connect(_on_inventory_updated)
	InventoryEvent.select_hotbar_slot.connect(_on_hotbar_slot_selected)
	InventoryEvent.change_hotbar_selection.connect(_on_hotbar_selection_changed)

func _exit_tree() -> void:
	InventoryEvent.inventory_initialized.disconnect(_on_inventory_initialized)
	InventoryEvent.inventory_updated.disconnect(_on_inventory_updated)
	InventoryEvent.select_hotbar_slot.disconnect(_on_hotbar_slot_selected)
	InventoryEvent.change_hotbar_selection.disconnect(_on_hotbar_selection_changed)

func _ready():
	generate_slots()
	update_selection()

func generate_slots():
	for child in get_children():
		child.queue_free()

	var hotbar_slots = inventory.get_hotbar_slots()

	for i in hotbar_slots.size():
		var slot_ui = slot_scene.instantiate()
		add_child(slot_ui)
		slot_ui.set_slot(hotbar_slots[i])

func update_selection():

	for i in get_child_count():
		var slot_ui = get_child(i)

		if i == selected_index:
			slot_ui.modulate = Color(1,1,1)
			slot_ui.scale = Vector2(1.1,1.1)
		else:
			slot_ui.modulate = Color(0.8,0.8,0.8)
			slot_ui.scale = Vector2(1,1)

func _on_inventory_initialized(inv):
	inventory = inv

func _on_inventory_updated():
	generate_slots()

func _on_hotbar_slot_selected(slot_index):
	selected_index = slot_index
	update_selection()

func _on_hotbar_selection_changed(direction):
	var hotbar_size = inventory.get_hotbar_slots().size()
	selected_index = (selected_index + direction) % hotbar_size
	update_selection()
