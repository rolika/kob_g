extends Node

const CUBE_DATA_PRECISION: float = 0.001
const STARTING_DIAMETER: int = 12

var company: String
var city: String
var site: String
var person: String
var type: String
var length: float
var cube_data: Array[int]
var count: Array[int]

func is_valid() -> bool:
    return not (company.is_empty() or city.is_empty() or site.is_empty() or person.is_empty())

func init() -> void:
    cube_data = File_IO.get_cubedata()
    count.resize(cube_data.size())
    count.fill(0)

func get_volume(diameter: int) -> float:
    var index = diameter - STARTING_DIAMETER
    return cube_data[index] * count[index] * CUBE_DATA_PRECISION

func get_total_volume() -> float:
    var total_volume = 0.0
    for i in range(count.size()):
        total_volume += get_volume(i + STARTING_DIAMETER)
    return total_volume
