extends Node

const CUBE_DATA_PRECISION: float = 0.001
const STARTING_DIAMETER: int = 12

var company: String
var city: String
var site: String
var person: String
var type: String
var length: float
var counter: Dictionary[int, int]

func is_valid() -> bool:
    return not (company.is_empty() or city.is_empty() or site.is_empty() or person.is_empty())

func init() -> void:
    assert(length)
    var cube_data = File_IO.get_cubedata()
    for cube in cube_data:
        counter[cube] = 0

func get_volume(cube: int) -> float:
    return cube * counter[cube] * CUBE_DATA_PRECISION

func get_total_volume() -> float:
    var total_volume = 0.0
    for cube in counter:
        total_volume += get_volume(cube)
    return total_volume

func increment(cube: int) -> void:
    counter[cube] += 1

func decrement(cube: int) -> void:
    counter[cube] -= 1
