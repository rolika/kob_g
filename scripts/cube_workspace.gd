extends Control


const CUBE_CONTROL = preload("res://scenes/cube_control.tscn")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    for i in range(15):
        var cube_control = CUBE_CONTROL.instantiate()
        $ScrollContainer/VBoxContainer.add_child(cube_control)
        cube_control.set_cube_data(15 + i, 20 + i)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
    pass
