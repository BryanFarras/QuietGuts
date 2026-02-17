extends Node
class_name CraftingSystem

@export var recipes: Array[CraftingRecipe]

var inventory: Inventory

func _enter_tree() -> void:
	InventoryEvent.inventory_updated.connect(_on_inventory_updated)

func _exit_tree() -> void:
	InventoryEvent.inventory_updated.disconnect(_on_inventory_updated)

func _ready():
	InventoryEvent.crafting_system_updated.emit(self)

func can_craft(recipe: CraftingRecipe) -> bool:

	for i in recipe.required_items.size():
		var item = recipe.required_items[i]
		var amount = recipe.required_amounts[i]

		if inventory.get_item_amount(item) < amount:
			return false

	return true


func craft(recipe: CraftingRecipe):

	if not can_craft(recipe):
		return false

	# remove materials
	for i in recipe.required_items.size():
		inventory.remove_item(
			recipe.required_items[i],
			recipe.required_amounts[i]
		)

	# add result
	inventory.add_item(recipe.result_item, recipe.result_amount)

	return true

func _on_inventory_updated(inv):
	inventory = inv