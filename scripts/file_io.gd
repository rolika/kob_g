extends Node

const USERFOLDER: String = "user://"
const DATAFILENAME: String = "kobozo.txt"
const DATAFILE: String = USERFOLDER + DATAFILENAME
const PILEFOLDER: String = USERFOLDER + "kob"
const KOBFILE_FMT: String = "%d.kob"
const IMAGEFILE_FMT: String = "%s_%s_%s_%d.png"

var download_folder: String = OS.get_system_dir(OS.SYSTEM_DIR_DOWNLOADS)

func _ready(datafile: String = DATAFILE, pilefolder: String = PILEFOLDER, datafilename: String = DATAFILENAME) -> void:
    if not FileAccess.file_exists(datafile):
        var datafile_in_download_folder: String = download_folder.path_join(datafilename)
        if not FileAccess.file_exists(datafile_in_download_folder):
            propagate_notification(NOTIFICATION_WM_GO_BACK_REQUEST)
        else:
            if DirAccess.copy_absolute(datafile_in_download_folder, datafile) != OK:
                propagate_notification(NOTIFICATION_WM_GO_BACK_REQUEST)
            else:
                if DirAccess.remove_absolute(datafile_in_download_folder) != OK:
                    OS.alert("Töröld a kobozo.txt file-t a Letöltések mappából!", "Hiba:")
    if not DirAccess.dir_exists_absolute(pilefolder):
        DirAccess.make_dir_absolute(pilefolder)

func _notification(what: int) -> void:
    if what == NOTIFICATION_WM_GO_BACK_REQUEST:
        OS.alert("Nem található a köböző adatfile: kobozo.txt.", "Hiba:")
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
    if CurrentPile.timestamp_for_filename == 0:
        CurrentPile.timestamp_for_filename = int(Time.get_unix_time_from_system())
    var filename: String = pilefolder.path_join(kobfile_fmt % CurrentPile.timestamp_for_filename)
    var file = FileAccess.open(filename, FileAccess.WRITE)
    if file:
        file.store_var(CurrentPile.get_session_data())
    else:
        OS.alert("Valamiért nem sikerült elmenteni...", "Hiba:")
    file.close()
        
func get_sessions(pilefolder: String = PILEFOLDER) -> Array[Dictionary]:    
    assert(DirAccess.dir_exists_absolute(pilefolder))
    var sessions: Array[Dictionary]
    for filename in DirAccess.get_files_at(pilefolder):
        var file = FileAccess.open(pilefolder.path_join(filename), FileAccess.READ)
        var session: Dictionary = file.get_var()
        var cubedata: Array = get_cubedata(session["type"], session["length"])
        if session.kobdata.size() == cubedata.size():
            sessions.append(session)
        else:
            print("A " + filename + " nevű köbözés adatai nem tölthetők be.")
        file.close()    
    if sessions.size() > 1:
        sessions.sort_custom(func(s1, s2): return s1.timestamp > s2.timestamp)  # newer come first
    return sessions

func delete_session(timestamp: int, pilefolder: String = PILEFOLDER, kobfile_fmt: String = KOBFILE_FMT) -> void:      
    assert(DirAccess.dir_exists_absolute(pilefolder))
    DirAccess.remove_absolute(pilefolder.path_join(kobfile_fmt % timestamp))
    
func save_report(image: Image, folder: String = download_folder, imagefile_fmt: String = IMAGEFILE_FMT) -> String:
    var filename: String = imagefile_fmt % [CurrentPile.company, CurrentPile.site, CurrentPile.type, CurrentPile.get_length_dm()]
    filename = filename.replace(" ", "_")
    var path: String = folder.path_join(filename)
    image.save_png(path)
    return path
