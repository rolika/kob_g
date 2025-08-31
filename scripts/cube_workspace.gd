extends Control


const CUBE_CONTROL = preload("res://scenes/cube_control.tscn")
const FILEPATH: String = "res://data/kobozo.txt"
const STARTING_DIAMETER: int = 15


@export var woodtype: String = "bükk"
@export var woodlength: float = 3.2


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    var cube_data: Array = get_cubedata(FILEPATH, woodtype, woodlength)
    for i in range(cube_data.size()):
        var cube_control = CUBE_CONTROL.instantiate()
        $ScrollContainer/VBoxContainer.add_child(cube_control)
        cube_control.set_cube_data(STARTING_DIAMETER + i, cube_data[i])


func get_cubedata(file_path: String, woodtype_: String, woodlength_: float) -> Array:
    var file = FileAccess.open(file_path, FileAccess.READ)
    var result = []  
    var line: String 
    
    if file:
        # find the wood type
        while file.get_position() < file.get_length():
            line = file.get_line()
            if line.begins_with(woodtype_):
                break
        # find the length        
        while file.get_position() < file.get_length():
            line = file.get_line()
            if line.begins_with(" " + str(woodlength_)):
                break
        # read the cube data
        var cubedata = line.split(":")[1]
        for number in cubedata.strip_edges().split(" "):
            result.append(int(number))
            
    return result
