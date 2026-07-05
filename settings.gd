extends Node


var muted:= false
var volume = 75
var snakehead_color = Color(0.0, 0.498, 0.0, 1.0)
var snakebody_color = Color(0.0, 0.957, 0.0, 1.0)

func Volume() -> void:
	var busidk = AudioServer.get_bus_index("Master")
	AudioServer.set_bus_mute(busidk,muted)
	AudioServer.set_bus_volume_db(busidk,linear_to_db(volume/100))
