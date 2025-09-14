extends Control

const PRECISION: float = 0.001
var counter: int
var diameter: int  # diamater is represented in centimetres
var cube: int  # cube data is represented in m3, must be multiplied by the given precision

func _ready() -> void:
    counter = 0
    set_cube_data()

func _on_decrease_button_pressed() -> void:
    counter -= 1

func _on_increase_button_pressed() -> void:
    counter += 1

func _process(_delta: float) -> void:
    var decrease_button: Button = $HBoxContainer/DecreaseButton
    var counter_label: Label = $HBoxContainer/GridContainer/CounterLabel
    var diameter_label: Label = $HBoxContainer/GridContainer/DiameterLabel
    var cubic_label: Label = $HBoxContainer/GridContainer/CubicLabel
    var volume_label: Label = $HBoxContainer/GridContainer/VolumeLabel
    if counter > 0:
        decrease_button.disabled = false
    else:
        decrease_button.disabled = true
    counter_label.text = str(counter)
    diameter_label.text = str(diameter)
    cubic_label.text = str(cube)
    volume_label.text = "%.2f" % get_volume()

func set_cube_data(diameter_: int = 20, cube_: int = 15) -> void:
    diameter = diameter_
    cube = cube_

func get_volume() -> float:
    return cube * counter * PRECISION
