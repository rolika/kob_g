extends Node2D


const CUBE_WORKSPACE = preload("res://scenes/cube_workspace.tscn")


func _ready() -> void:
    var file_path = "res://data/kobozo.txt"
    
    var cube_workspace = CUBE_WORKSPACE.instantiate()
    add_child(cube_workspace)
    cube_workspace.set_position(Vector2(0, 0))
    
    for data in get_cubedata(file_path, "tölgy", 3.1):
        print(data)


func get_cubedata(file_path: String, woodtype: String, length: float) -> Array:
    var file = FileAccess.open(file_path, FileAccess.READ)
    var result = []  
    var line: String 
    
    if file:
        # find the wood type
        while file.get_position() < file.get_length():
            line = file.get_line()
            if line.begins_with(woodtype):
                break
        # find the length        
        while file.get_position() < file.get_length():
            line = file.get_line()
            if line.begins_with(" " + str(length)):
                break
        # read the cube data
        var cubedata = line.split(":")[1]
        for number in cubedata.strip_edges().split(" "):
            result.append(str(number))
    return result
