extends Node2D

const CUBE_CONTROL = preload("res://scenes/cube_control.tscn")

func _ready() -> void:
    var index = 0
    for cube in CurrentPile.counter:
        var cube_control = CUBE_CONTROL.instantiate()
        $ScrollContainer/VBoxContainer.add_child(cube_control)
        cube_control.set_cube_data(CurrentPile.STARTING_DIAMETER + index, cube)
        index += 1
