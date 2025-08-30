extends Node2D


const CUBE_WORKSPACE = preload("res://scenes/cube_workspace.tscn")


func _ready() -> void:
    var file_path = "res://data/kobozo.txt"
    
    var cube_workspace = CUBE_WORKSPACE.instantiate()
    add_child(cube_workspace)
    cube_workspace.set_position(Vector2(0, 0))
    
    for line in get_wood_types(file_path):
        print(line)


func get_wood_types(file_path: String) -> Array:
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
