extends Node

signal open_inventory
signal close_inventory
signal toggle_inventory

signal add_item_to_inventory(item_data, amount)
signal remove_item_from_inventory(item_data, amount)

signal inventory_initialized(inventory)
signal inventory_updated(inventory)
