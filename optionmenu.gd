extends Control


@onready var check_button: CheckButton = $CheckButton
@onready var vol: HSlider = $vol
@onready var color_picker_button: ColorPickerButton = $ColorPickerButton
@onready var color_picker_button_2: ColorPickerButton = $ColorPickerButton2
@onready var button: Button = $Button




func _ready() -> void:
	check_button.button_pressed = Settings.muted
	vol.value = Settings.volume
	color_picker_button.color = Settings.snakehead_color
	color_picker_button_2.color = Settings.snakebody_color
	
	
	check_button.toggled.connect(_on_check_button_toggled)
	vol.value_changed.connect(_on_vol_changed)
	color_picker_button.color_changed.connect(_on_color_picker_button_color_changed)
	color_picker_button_2.color_changed.connect(_on_color_picker_button_2_color_changed)
	button.pressed.connect(_on_button_pressed)
	
	
	
	
	
	
	


func _on_check_button_toggled(toggled_on: bool) -> void:
	Settings.muted = toggled_on
	Settings.Volume()


func _on_vol_changed(value:float) -> void:
	Settings.volume = value
	Settings.Volume()



func _on_color_picker_button_color_changed(color: Color) -> void:
	Settings.snakehead_color= color

func _on_color_picker_button_2_color_changed(color: Color) -> void:
	Settings.snakebody_color = color




func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://mainmenu.tscn")
	
