extends Node

const DATAFILE: String = "res://data/kobozo.txt"
const PILEFOLDER: String = "user://kob"

func _init(datafile: String = DATAFILE, pilefolder: String = PILEFOLDER) -> void:
    if not FileAccess.file_exists(datafile):
        get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
    if not DirAccess.dir_exists_absolute(pilefolder):
        DirAccess.make_dir_absolute(pilefolder)

func _notification(what: int) -> void:
    if what == NOTIFICATION_WM_CLOSE_REQUEST:
        # TODO: display some model about the missing kobfile        
        get_tree().quit()

func get_woodtypes(file_path: String = DATAFILE) -> Array[String]:
    var file = FileAccess.open(file_path, FileAccess.READ)
    var result: Array[String] = []       
    if file:
        while file.get_position() < file.get_length():
            var line: String = file.get_line()
            if not line.begins_with(" "):
                line = line.trim_suffix(":")
                result.append(line)
        file.close()                    
    return result    

func get_woodlengths(file_path: String = DATAFILE) -> Array[float]:    
    var file = FileAccess.open(file_path, FileAccess.READ)
    var result: Array[float] = []       
    if file:
        # find the wood type
        while file.get_position() < file.get_length():
            var line = file.get_line()
            if line.begins_with(CurrentPile.type):
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

func get_cubedata(file_path: String = DATAFILE) -> Array[int]:
    var file = FileAccess.open(file_path, FileAccess.READ)
    var result: Array[int] = []  
    var line: String     
    if file:
        # find the wood type
        while file.get_position() < file.get_length():
            line = file.get_line()
            if line.begins_with(CurrentPile.type):
                break
        # find the length        
        while file.get_position() < file.get_length():
            line = file.get_line()
            if line.begins_with(" " + str(CurrentPile.length)):
                break
        # read the cube data
        var cubedata = line.split(":")[1]
        for number in cubedata.strip_edges().split(" "):
            result.append(int(number))            
    return result
