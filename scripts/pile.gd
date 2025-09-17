extends Node

class_name Pile

var company: String
var city: String
var site: String
var person: String
var type: String
var length: float
var count: Array[int]

func is_valid() -> bool:
    return not (company.is_empty() or city.is_empty() or site.is_empty() or person.is_empty())
