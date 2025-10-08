extends Node

const DATAFILE: String = "res://data/kobozo.txt"
const PILEFOLDER: String = "user://kob"
const KOBFILE_FMT: String = "pile_%03d.kob"

func _init(datafile: String = DATAFILE, pilefolder: String = PILEFOLDER) -> void:
    if not FileAccess.file_exists(datafile):
        get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
    if not DirAccess.dir_exists_absolute(pilefolder):
        DirAccess.make_dir_absolute(pilefolder)

func _notification(what: int) -> void:
    if what == NOTIFICATION_WM_CLOSE_REQUEST:
        # TODO: display modal about the missing kobfile        
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

func _get_session_count(pilefolder: String = PILEFOLDER) -> int:
    return get_sessions(pilefolder).size() + 1   # the default 0. index is used to check on a new session

func write_session(pilefolder: String = PILEFOLDER, kobfile_fmt: String = KOBFILE_FMT) -> void:
    assert(DirAccess.dir_exists_absolute(pilefolder))
    if CurrentPile.index == 0:
        CurrentPile.index = _get_session_count()
    update_session(pilefolder, kobfile_fmt)

func update_session(pilefolder: String = PILEFOLDER, kobfile_fmt: String = KOBFILE_FMT) -> void:
    assert(CurrentPile.index != 0)
    var filename: String = pilefolder.path_join(kobfile_fmt % CurrentPile.index)
    var file = FileAccess.open(filename, FileAccess.WRITE)
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
        var num: String = filename.split("_")[1]  # filename-format: KOBFILE_FMT
        num = num.split(".")[0]
        var index: int = int(num)
        var file = FileAccess.open(pilefolder.path_join(filename), FileAccess.READ)
        sessions.append(file.get_var())
        sessions[-1]["index"] = index
        file.close()
    return sessions
