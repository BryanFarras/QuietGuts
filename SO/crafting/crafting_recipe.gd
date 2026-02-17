extends Resource
class_name CraftingRecipe

@export var result_item: ItemData
@export var result_amount: int = 1

@export var required_items: Array[ItemData]
@export var required_amounts: Array[int]
