extends Panel

@onready var icon: Sprite2D = $CenterContainer/Panel/Icon
@onready var amount_label: Label = $CenterContainer/Panel/AmountLabel

var slot: SlotData

func _get_drag_data(at_position):

	if slot == null or slot.item == null:
		return null

	var preview = TextureRect.new()
	preview.texture = slot.item.icon
	preview.expand = true
	preview.size = Vector2(32, 32)

	set_drag_preview(preview)

	return {
		"slot": slot,
		"source_ui": self
	}

func _can_drop_data(at_position, data):
	return data.has("slot")

func _drop_data(at_position, data):

	var from_slot: SlotData = data["slot"]
	var to_slot: SlotData = slot

	if from_slot == to_slot:
		return

	swap_or_merge(from_slot, to_slot)

	InventoryEvent.inventory_updated.emit()

func swap_or_merge(from_slot: SlotData, to_slot: SlotData):

	# Kalau kosong → pindah
	if to_slot.item == null:
		to_slot.item = from_slot.item
		to_slot.amount = from_slot.amount

		from_slot.item = null
		from_slot.amount = 0
		return

	# Kalau item sama → stack
	if to_slot.item == from_slot.item:

		var space = to_slot.item.max_stack - to_slot.amount
		var move_amount = min(space, from_slot.amount)

		to_slot.amount += move_amount
		from_slot.amount -= move_amount

		if from_slot.amount <= 0:
			from_slot.item = null
			from_slot.amount = 0
		return

	# Kalau beda item → swap
	var temp_item = to_slot.item
	var temp_amount = to_slot.amount

	to_slot.item = from_slot.item
	to_slot.amount = from_slot.amount

	from_slot.item = temp_item
	from_slot.amount = temp_amount

func set_slot(new_slot: SlotData):
	slot = new_slot
	update_slot(slot)

func update_slot(new_slot: SlotData = null):
	if new_slot != null:
		slot = new_slot

	if slot == null or slot.item == null:
		icon.texture = null
		amount_label.text = ""
	else:
		icon.texture = slot.item.icon
		amount_label.text = str(slot.amount) if slot.amount > 1 else ""
