extends Node


var music : AudioStreamPlayer

func _ready() -> void:
	music = AudioStreamPlayer.new(
		
	)
	add_child(music)
	music.stream = preload("res://alexzavesa-crash-protection-10943.mp3")
	music.bus = "master"
	music.play(
		
	)
	
	
func stopbgmusic() -> void:
	music.stop()
	
	
func playmsuic() -> void:
	music.play(
		
	)
