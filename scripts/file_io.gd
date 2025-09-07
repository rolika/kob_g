extends Node


const DATAFILE: String = "res://data/kobozo.txt"


func get_woodtypes(file_path: String = DATAFILE) -> Array:
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
    

func get_woodlengths(woodtype: String, file_path: String = DATAFILE) -> Array:    
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


func get_cubedata(woodtype: String, woodlength: float, file_path: String = DATAFILE) -> Array:
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
            if line.begins_with(" " + str(woodlength)):
                break
        # read the cube data
        var cubedata = line.split(":")[1]
        for number in cubedata.strip_edges().split(" "):
            result.append(int(number))
            
    return result
