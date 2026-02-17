extends Area2D

@export var item_data: ItemData
@export var amount: int = 1

@onready var sprite_2d: Sprite2D = $Sprite2D

func _ready():
	sprite_2d.texture = item_data.icon
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if body.is_in_group("player"):
		InventoryEvent.add_item_to_inventory.emit(item_data, amount)
		queue_free()
