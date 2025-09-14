extends Node2D


const CUBE_CONTROL = preload("res://scenes/cube_control.tscn")
const STARTING_DIAMETER: int = 12


@export var woodtype: String = "tölgy"
@export var woodlength: float = 2.0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    var cube_data: Array = File_IO.get_cubedata(woodtype, woodlength)
    print(cube_data.size())
    for i in range(cube_data.size()):
        var cube_control = CUBE_CONTROL.instantiate()
        $ScrollContainer/VBoxContainer.add_child(cube_control)
        cube_control.set_cube_data(STARTING_DIAMETER + i, cube_data[i])
