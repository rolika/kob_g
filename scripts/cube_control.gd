extends Control

var diameter: int  # diamater is represented in centimetres
var cube: int  # the statistical cube data as an integer (precision is hardcoded in pile.gd)

func _ready() -> void:
    set_cube_data()

func _on_decrease_button_pressed() -> void:
    CurrentPile.decrement(cube)
    Input.vibrate_handheld(250)
    File_IO.update_session()

func _on_increase_button_pressed() -> void:    
    CurrentPile.increment(cube)
    Input.vibrate_handheld(250)
    File_IO.update_session()

func _process(_delta: float) -> void:
    var decrease_button: Button = $HBoxContainer/DecreaseButton
    var counter_label: Label = $HBoxContainer/CounterGrid/CounterLabel
    var diameter_label: Label = $HBoxContainer/DiameterVBox/DiameterLabel
    var cube_label: Label = $HBoxContainer/CubeVBox/CubeLabel
    var volume_label: Label = $HBoxContainer/CounterGrid/VolumeLabel
    if CurrentPile.counter[cube] > 0:
        decrease_button.disabled = false
    else:
        decrease_button.disabled = true
    counter_label.text = str(CurrentPile.counter[cube])
    diameter_label.text = str(diameter)
    cube_label.text = str(int(round(cube / 10.0)))
    volume_label.text = CurrentPile.get_volume_fmt(cube)

func set_cube_data(diameter_: int = 20, cube_: int = 15) -> void:
    diameter = diameter_
    cube = cube_
