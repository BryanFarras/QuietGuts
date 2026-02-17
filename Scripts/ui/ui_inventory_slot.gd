extends Panel

@onready var icon: Sprite2D = $CenterContainer/Panel/Icon
@onready var amount_label: Label = $CenterContainer/Panel/AmountLabel

func update_slot(slot: InventorySlot):
	if slot and !slot.is_empty():
		icon.texture = slot.item.icon
		icon.visible = true
		amount_label.text = str(slot.amount)
		if slot.amount > 1:
			amount_label.visible = true
		else:
			amount_label.visible = false
	else:
		icon.visible = false
		amount_label.visible = false
