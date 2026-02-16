extends CanvasLayer

@onready var player = $"../Player"
@onready var inventory = player.get_node("Inventory")

@onready var wood_label = $VBoxContainer/WoodLabel
@onready var stone_label = $VBoxContainer/StoneLabel
@onready var food_label = $VBoxContainer/FoodLabel

func _ready():
	InventoryEvent.inventory_updated.connect(Callable(self, "update_ui"))
	update_ui()

func update_ui():
	wood_label.text = "Wood: " + str(inventory.get_amount(ResourceBase.ResourceType.WOOD))
	stone_label.text = "Stone: " + str(inventory.get_amount(ResourceBase.ResourceType.STONE))
