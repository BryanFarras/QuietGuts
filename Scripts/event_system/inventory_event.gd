extends Node

signal open_inventory
signal close_inventory
signal toggle_inventory

signal add_item_to_inventory(item_data, amount)
signal remove_item_from_inventory(item_data, amount)

signal inventory_initialized(inventory)
signal inventory_updated()

signal crafting_system_updated(crafting_system)

signal select_hotbar_slot(slot_index)
signal change_hotbar_selection(direction) # direction: -1 for left, +1 for right
