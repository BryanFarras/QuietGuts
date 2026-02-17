extends Control

@onready var inventory_button: Button = $TabButtons/InventoryButton
@onready var crafting_button: Button = $TabButtons/CraftingButton

@onready var inventory_panel = $InventoryPanel
@onready var crafting_panel = $CraftingPanel

func _unhandled_input(event):
	if event.is_action_pressed("inventory"):
		visible = !visible

func _ready():
	inventory_button.connect("pressed", Callable(self, "show_inventory"))
	crafting_button.connect("pressed", Callable(self, "show_crafting"))
	
	show_inventory()

func show_inventory():
	inventory_panel.visible = true
	crafting_panel.visible = false

func show_crafting():
	inventory_panel.visible = false
	crafting_panel.visible = true
