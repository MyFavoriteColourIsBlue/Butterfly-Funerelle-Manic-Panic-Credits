class_name InventoryData extends Resource

@export var slots : Array[ SlotData ]


func add_item( item : ItemData, count : int = 1 ) -> bool:
	for s in slots:
		if s:
			if s.item_data == item:
				s.quantity += count
				return true
	
	for i in slots.size():
		if slots[ i ] == null:
			var new = SlotData.new()
			new.item_data = item
			new.quantity = count
			slots[ i ] = new
			return true
	
	print( "inventory was full!")
	return false



## Gather the inventory into an array
func get_save_data() -> Array: 
	var item_save : Array = []
	for i in slots.size(): 
		item_save.append('')
	return item_save

## Convert each inventory item into a dictionary
func item_to_save( slot : SlotData ) -> Dictionary:
	var result = { item = "", quantity = 0 }
	if slot != null:
		result.quantity = slot.quantity
		if slot.item_data != null:
			result.item = slot.item_data.resource_path
	return result
