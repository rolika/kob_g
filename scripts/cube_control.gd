extends Control

var diameter: int  # diamater is represented in centimetres
var cube: int  # the statistical cube data as an integer

@onready var decrease_button: Button = $HBoxContainer/DecreaseButton
@onready var counter_label: Label = $HBoxContainer/CounterGrid/CounterLabel
@onready var diameter_label: Label = $HBoxContainer/DiameterVBox/DiameterLabel
@onready var cube_label: Label = $HBoxContainer/CubeVBox/CubeLabel
@onready var volume_label: Label = $HBoxContainer/CounterGrid/VolumeLabel
@onready var precision_label: Label = $HBoxContainer/CubeVBox/HBoxContainer/PrecisionLabel

func _ready() -> void:
    set_cube_data()

func _on_decrease_button_pressed() -> void:
    CurrentPile.decrement(cube)
    $SubtractAudio.play()
    Input.vibrate_handheld(200)
    File_IO.write_session()

func _on_increase_button_pressed() -> void:    
    CurrentPile.increment(cube)
    $AddAudio.play()
    Input.vibrate_handheld(200)
    File_IO.write_session()

func _process(_delta: float) -> void:
    if CurrentPile.counter[cube] > 0:
        decrease_button.disabled = false
    else:
        decrease_button.disabled = true
    counter_label.text = str(CurrentPile.counter[cube])
    diameter_label.text = str(diameter)
    cube_label.text = CurrentPile.get_cube_label_text(cube)
    volume_label.text = CurrentPile.get_volume_formatted(cube)
    precision_label.text = CurrentPile.get_precision_label()

func set_cube_data(diameter_: int = 20, cube_: int = 15) -> void:
    diameter = diameter_
    cube = cube_
