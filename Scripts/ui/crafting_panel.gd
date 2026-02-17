extends Panel

@onready var recipe_list: VBoxContainer = $NinePatchRect/RecipeList
@onready var required_list: VBoxContainer = $NinePatchRect/RequiredList

@onready var craft_button: Button = $NinePatchRect/CraftButton

var inventory: Inventory
var crafting_system: CraftingSystem
var selected_recipe: CraftingRecipe

func _enter_tree() -> void:
	InventoryEvent.inventory_updated.connect(_on_inventory_updated)
	InventoryEvent.crafting_system_updated.connect(_on_crafting_system_updated)

func _exit_tree() -> void:
	InventoryEvent.inventory_updated.disconnect(_on_inventory_updated)
	InventoryEvent.crafting_system_updated.disconnect(_on_crafting_system_updated)

func _ready():
	craft_button.pressed.connect(_on_CraftButton_pressed)
	
	populate_recipes()

func populate_recipes():
	for recipe in crafting_system.recipes:
		var button = Button.new()
		button.text = recipe.result_item.name
		button.pressed.connect(_on_recipe_selected.bind(recipe))
		recipe_list.add_child(button)

func _on_recipe_selected(recipe: CraftingRecipe):
	selected_recipe = recipe
	update_required_list()

func update_required_list():

	for child in required_list.get_children():
		child.queue_free()

	for i in selected_recipe.required_items.size():

		var item = selected_recipe.required_items[i]
		var required_amount = selected_recipe.required_amounts[i]
		var owned_amount = inventory.get_item_amount(item)

		var label = Label.new()
		label.text = "%s: %d / %d" % [
			item.name,
			owned_amount,
			required_amount
		]

		required_list.add_child(label)

func _on_CraftButton_pressed():

	if selected_recipe == null:
		return

	if crafting_system.craft(selected_recipe):
		update_required_list()

func _on_inventory_updated(inv):
	inventory = inv

	if selected_recipe:
		update_required_list()

func _on_crafting_system_updated(cs):
	crafting_system = cs
