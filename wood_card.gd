extends Node2D

const PRECISION: float = 0.01

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
	if counter> 0:
		$DecreaseButton.disabled = false
	else:
		$DecreaseButton.disabled = true
	$QuantityLabel.text = str(counter)
	$DiameterLabel.text = str(diameter)
	$CubeLabel.text = str(cube)
	$VolumeLabel.text = "%.2f" % (cube * counter * PRECISION)


func set_cube_data(diameter_: int = 20, cube_: int = 15) -> void:
	diameter = diameter_
	cube = cube_
