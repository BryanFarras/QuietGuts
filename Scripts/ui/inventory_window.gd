extends Control

@onready var tab_buttons: HBoxContainer = $TabButtons
@onready var inventory_button: Button = $TabButtons/InventoryButton
@onready var crafting_button: Button = $TabButtons/CraftingButton

@onready var inventory_panel = $InventoryPanel
@onready var crafting_panel = $CraftingPanel
@onready var hotbar_panel = $HotbarPanel

var isOpen: bool = false

func _enter_tree() -> void:
	InventoryEvent.open_inventory.connect(Callable(self, "show_inventory"))
	InventoryEvent.close_inventory.connect(Callable(self, "hide_all_panels"))
	InventoryEvent.toggle_inventory.connect(Callable(self, "toggle_inventory"))

func _exit_tree() -> void:
	InventoryEvent.open_inventory.disconnect(Callable(self, "show_inventory"))
	InventoryEvent.close_inventory.disconnect(Callable(self, "hide_all_panels"))
	InventoryEvent.toggle_inventory.disconnect(Callable(self, "toggle_inventory"))
func _ready():
	inventory_button.connect("pressed", Callable(self, "show_inventory"))
	crafting_button.connect("pressed", Callable(self, "show_crafting"))
	
	hide_all_panels()

func toggle_inventory():
	isOpen = !isOpen
	if isOpen:
		show_inventory()
	else:
		hide_all_panels()

func hide_all_panels():
	tab_buttons.visible = false
	inventory_panel.visible = false
	crafting_panel.visible = false

func show_inventory():
	tab_buttons.visible = true
	inventory_panel.visible = true
	crafting_panel.visible = false

func show_crafting():
	tab_buttons.visible = true
	inventory_panel.visible = false
	crafting_panel.visible = true
