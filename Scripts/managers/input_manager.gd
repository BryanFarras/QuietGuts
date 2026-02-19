extends Node

func _input(event):
	if event.is_action_pressed("inventory"):
		InventoryEvent.toggle_inventory.emit()
	
	if event is InputEventKey and event.pressed:

		match event.keycode:
			KEY_1:
				InventoryEvent.select_hotbar_slot.emit(0)
			KEY_2:
				InventoryEvent.select_hotbar_slot.emit(1)
			KEY_3:
				InventoryEvent.select_hotbar_slot.emit(2)
			KEY_4:
				InventoryEvent.select_hotbar_slot.emit(3)
			KEY_5:
				InventoryEvent.select_hotbar_slot.emit(4)
			KEY_6:
				InventoryEvent.select_hotbar_slot.emit(5)
			KEY_7:
				InventoryEvent.select_hotbar_slot.emit(6)
			KEY_8:
				InventoryEvent.select_hotbar_slot.emit(7)
			KEY_9:
				InventoryEvent.select_hotbar_slot.emit(8)
			KEY_0:
				InventoryEvent.select_hotbar_slot.emit(9)
		
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			InventoryEvent.change_hotbar_selection.emit(-1)
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			InventoryEvent.change_hotbar_selection.emit(1)
