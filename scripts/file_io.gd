extends Node

const DATAFILE: String = "res://data/kobozo.txt"
const PILEFOLDER: String = "user://kob"
const KOBFILE_FMT: String = "%d.kob"

func _init(datafile: String = DATAFILE, pilefolder: String = PILEFOLDER) -> void:
    if not FileAccess.file_exists(datafile):
        get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
    if not DirAccess.dir_exists_absolute(pilefolder):
        DirAccess.make_dir_absolute(pilefolder)

func _notification(what: int) -> void:
    if what == NOTIFICATION_WM_CLOSE_REQUEST:
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
        file.close()                        
    return result

func get_cubedata(type: String = CurrentPile.type, length: float = CurrentPile.length, file_path: String = DATAFILE) -> Array[int]:
    var file = FileAccess.open(file_path, FileAccess.READ)
    var result: Array[int] = []  
    var line: String     
    if file:
        # find the wood type
        while file.get_position() < file.get_length():
            line = file.get_line()
            if line.begins_with(type):
                break
        # find the length        
        while file.get_position() < file.get_length():
            line = file.get_line()
            if line.begins_with(" " + str(length)):
                break
        # read the cube data
        var cubedata = line.split(":")[1]
        for number in cubedata.strip_edges().split(" "):
            result.append(int(number))            
        file.close()                    
    return result

func write_session(pilefolder: String = PILEFOLDER, kobfile_fmt: String = KOBFILE_FMT) -> void:
    assert(DirAccess.dir_exists_absolute(pilefolder))
    var old_filename: String = pilefolder.path_join(kobfile_fmt % CurrentPile.former_timestamp)
    var new_filename: String = pilefolder.path_join(kobfile_fmt % CurrentPile.timestamp)
    DirAccess.rename_absolute(old_filename, new_filename)
    var file = FileAccess.open(new_filename, FileAccess.WRITE)
    if file:
        file.store_var(CurrentPile.get_session_data())
    else:
        pass
        # TODO: display a modal about the failed file access
    file.close()
        
func get_sessions(pilefolder: String = PILEFOLDER) -> Array[Dictionary]:    
    assert(DirAccess.dir_exists_absolute(pilefolder))
    var sessions: Array[Dictionary]
    for filename in DirAccess.get_files_at(pilefolder):
        var file = FileAccess.open(pilefolder.path_join(filename), FileAccess.READ)
        sessions.append(file.get_var())
        file.close()    
    if sessions.size() > 1:
        sessions.sort_custom(func(s1, s2): return s1.timestamp > s2.timestamp)  # newer come first
    return sessions

func delete_session(timestamp: int, pilefolder: String = PILEFOLDER, kobfile_fmt: String = KOBFILE_FMT) -> void:      
    assert(DirAccess.dir_exists_absolute(pilefolder))
    DirAccess.remove_absolute(pilefolder.path_join(kobfile_fmt % timestamp))
