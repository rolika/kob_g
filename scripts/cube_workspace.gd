extends Node2D

const CUBE_CONTROL = preload("res://scenes/cube_control.tscn")

func _ready() -> void:
    var cube_data: Array = File_IO.get_cubedata()
    for i in range(cube_data.size()):
        var cube_control = CUBE_CONTROL.instantiate()
        $ScrollContainer/VBoxContainer.add_child(cube_control)
        cube_control.set_cube_data(CurrentPile.STARTING_DIAMETER + i, cube_data[i])
        
func _process(_delta: float) -> void:
    $SubtitleLabel.text = "Farakás: %.3f m3" % get_total_volume()

func get_total_volume() -> float:
    var total: float = 0.0
    for single in $ScrollContainer/VBoxContainer.get_children():
        total += single.get_volume()
    return total
