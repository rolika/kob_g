extends Node2D


const CUBE_WORKSPACE = preload("res://scenes/cube_workspace.tscn")


func _ready() -> void:
    var file_path = "res://data/kobozo.txt"
    
    var cube_workspace = CUBE_WORKSPACE.instantiate()
    add_child(cube_workspace)
    cube_workspace.set_position(Vector2(0, 0))
    
    for line in get_woodtypes(file_path):
        print(line)
    
    for length in get_woodlengths(file_path, "bükk"):
        print(length)
    
    for data in get_cubedata(file_path, "tölgy", 3.1):
        print(data)


func get_woodtypes(file_path: String) -> Array:
    var file = FileAccess.open(file_path, FileAccess.READ)
    var result = []   
    
    if file:
        while file.get_position() < file.get_length():
            var line = file.get_line()
            if not line.begins_with(" "):
                line = line.trim_suffix(":")
                result.append(line)
        file.close()
                    
    return result


func get_woodlengths(file_path: String, woodtype: String) -> Array:    
    var file = FileAccess.open(file_path, FileAccess.READ)
    var result = []   
    
    if file:
        # find the wood type
        while file.get_position() < file.get_length():
            var line = file.get_line()
            if line.begins_with(woodtype):
                break
        # read the lengths        
        while file.get_position() < file.get_length():
            var line = file.get_line()
            if not line.begins_with(" "):  # next wood type reached
                break
            var index_of_colon = line.find(":")
            var length = line.left(index_of_colon + 1)
            result.append(length.to_float())
            
    return result


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
