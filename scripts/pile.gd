extends Node

class_name Pile

const CUBE_DATA_PRECISION: float = 0.001
const STARTING_DIAMETER: int = 12

var company: String
var city: String
var site: String
var person: String
var type: String
var length: float
var counter: Dictionary[int, int]
var index: int = 0
var timestamp: int = int(Time.get_unix_time_from_system())

func is_valid() -> bool:
    return not (company.is_empty() or city.is_empty() or site.is_empty() or person.is_empty())

func init() -> void:
    assert(length)
    var cube_data = File_IO.get_cubedata()
    for cube in cube_data:
        counter[cube] = 0
    File_IO.write_session()

func get_volume(cube: int) -> float:
    return cube * counter[cube] * CUBE_DATA_PRECISION

func get_total_volume() -> float:
    var total_volume = 0.0
    for cube in counter:
        total_volume += get_volume(cube)
    return total_volume

func increment(cube: int) -> void:
    counter[cube] += 1
    timestamp = int(Time.get_unix_time_from_system())

func decrement(cube: int) -> void:
    counter[cube] -= 1
    timestamp = int(Time.get_unix_time_from_system())

func get_session_data() -> Dictionary:
    var kobdata: Array[int]
    for cube in counter:
        kobdata.append(counter[cube])
    var session = {
        "company": company,
        "city": city,
        "site": site,
        "person": person,
        "type": type,
        "length": length,
        "kobdata": kobdata,
        "timestamp": timestamp
    }
    return session

func set_session_data(session: Dictionary) -> void:
    index = session.index
    company = session.company
    city = session.city
    site = session.site
    person = session.person
    type = session.type
    length = session.length
    timestamp = session.timestamp
    var cube_data = File_IO.get_cubedata(session.type, session.length)
    for cube in cube_data:
        counter[cube] = 0
    var i = 0
    for cube in counter:
        counter[cube] = session.kobdata[i]
        i += 1

func translate_decimal(num: Variant) -> Variant:
    if is_instance_of(num, TYPE_FLOAT):
        var text = "%.2f" % num
        return text.replace(".", ",")
    elif is_instance_of(num, TYPE_STRING):
        return float(num.replace(",", "."))
    return -1

func get_total_volume_fmt() -> String:
    return translate_decimal(get_total_volume()) + " m3"

func get_volume_fmt(cube: int) -> String:
    return translate_decimal(get_volume(cube))

func get_length_fmt(length_: float = length) -> String:
    return translate_decimal(length_) + " m"
