extends Control


const CUBE_CONTROL = preload("res://scenes/cube_control.tscn")
const STARTING_DIAMETER: int = 15


@export var woodtype: String = "bükk"
@export var woodlength: float = 3.2


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    var cube_data: Array = File_IO.get_cubedata(woodtype, woodlength)
    for i in range(cube_data.size()):
        var cube_control = CUBE_CONTROL.instantiate()
        $ScrollContainer/VBoxContainer.add_child(cube_control)
        cube_control.set_cube_data(STARTING_DIAMETER + i, cube_data[i])
