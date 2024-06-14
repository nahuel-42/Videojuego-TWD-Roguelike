extends HSlider

@export
var bus_name: String

var bus_index=0


func _ready() -> void:
	var variable :HSlider = $"."
	value_changed.connect(_on_value_changed)
	variable.value = db_to_linear(AudioServer.get_bus_volume_db(bus_index))
	
func _on_value_changed(value:float) -> void:
	AudioServer.set_bus_volume_db(bus_index, 
	linear_to_db(value))
