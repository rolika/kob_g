class_name Pile extends Node

const STARTING_DIAMETER: int = 12

enum Precision {TWO_DIGITS = 2, THREE_DIGITS = 3}
const TWO_DIGIT_FMT: String = "%.2f"
const THREE_DIGIT_FMT: String = "%.3f"

var company: String
var city: String
var site: String
var person: String
var type: String
var length: float
var counter: Dictionary[int, int]
var timestamp: int
var labeling_precision: int = Precision.TWO_DIGITS
var calculation_precision: int = Precision.TWO_DIGITS
var data_precision: float = 0.01 if calculation_precision == Precision.TWO_DIGITS else 0.001
var volume_format: String = TWO_DIGIT_FMT if calculation_precision == Precision.TWO_DIGITS else THREE_DIGIT_FMT
var length_format: String = TWO_DIGIT_FMT
var timestamp_for_filename: int

func is_valid() -> bool:
    return not (company.is_empty() or city.is_empty() or site.is_empty() or person.is_empty())

func init() -> void:
    assert(length)
    _reset_counter()
    timestamp_for_filename = 0
    File_IO.write_session()

func reset_pile() -> void:
    company = ""
    city = ""
    site = ""
    person = ""
    type = ""
    length = 0.0
    counter = {}

func _reset_counter(type_: String = CurrentPile.type, length_: float = CurrentPile.length) -> void:    
    var cube_data = File_IO.get_cubedata(type_, length_)
    for cube in cube_data:
        counter[cube] = 0

func update_precision() -> void:
    data_precision = 0.01 if calculation_precision == Precision.TWO_DIGITS else 0.001
    volume_format = TWO_DIGIT_FMT if calculation_precision == Precision.TWO_DIGITS else THREE_DIGIT_FMT

func get_volume(cube: int) -> float:
    return get_precision_cube_value(cube, calculation_precision) * counter[cube] * data_precision

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
        "timestamp": timestamp,
        "timestamp_for_filename": timestamp_for_filename
    }
    return session

func set_session_data(session: Dictionary) -> void:
    company = session.company
    city = session.city
    site = session.site
    person = session.person
    type = session.type
    length = session.length
    timestamp = session.timestamp
    timestamp_for_filename = session.timestamp_for_filename
    _reset_counter(session.type, session.length)
    var i = 0
    for cube in counter:
        counter[cube] = session.kobdata[i]
        i += 1

func translate_decimal(num: Variant, fmt: String = THREE_DIGIT_FMT) -> Variant:
    if is_instance_of(num, TYPE_FLOAT):
        var text = fmt % num
        return text.replace(".", ",")
    elif is_instance_of(num, TYPE_STRING):
        return float(num.replace(",", "."))
    return -1

func get_total_volume_formatted() -> String:
    return translate_decimal(get_total_volume(), volume_format) + " m3"

func get_volume_formatted(cube: int) -> String:
    return translate_decimal(get_volume(cube), volume_format)

func get_length_formatted(length_: float = length) -> String:
    return translate_decimal(length_, length_format) + " m"

func get_cube_label_text(cube: int) -> String:
    return str(get_precision_cube_value(cube, labeling_precision))

func get_precision_label() -> String:
    return "század" if labeling_precision == Precision.TWO_DIGITS else "ezred"

func get_precision_cube_value(cube: int, precision: int) -> int:
    # data is stored with 3 digits precision, converse only if 2 digits precision is set
    if precision == Precision.TWO_DIGITS:
        var integer_part: int = int(cube / 10.0)
        if cube % 10 >= 5:
            integer_part += 1
        return integer_part
    else:
        return cube

func get_single_volume(cube: int) -> String:
    return translate_decimal(get_precision_cube_value(cube, calculation_precision) * data_precision, volume_format)

func get_volume_for(cube: int) -> String:
    return translate_decimal(get_volume(cube), volume_format)

func get_length_dm() -> int:
    return int(length * 10)

func get_total_quantity() -> int:
    var total_pieces = 0
    for count in counter.values():
        total_pieces += count
    return total_pieces
