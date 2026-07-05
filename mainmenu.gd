extends Control

@onready var start: Button = $start
@onready var options: Button = $OPTIONS



func _ready() -> void:
	start.pressed.connect(_on_start_pressed)
	options.pressed.connect(_on_options_pressed)
	
	
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		_on_start_pressed()
		

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://main.tscn")
	
	


func _on_options_pressed() -> void:
	get_tree().change_scene_to_file("res://optionmenu.tscn")
	
