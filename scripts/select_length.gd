extends Control


const FILEPATH: String = "res://data/kobozo.txt"
const ICON: CompressedTexture2D = preload("res://icon.svg")


@export var woodtype: String = "bükk"
@export var selected_length: float = 2.0


signal length_selected(type: String, length: float)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    for woodlength in get_woodlengths(FILEPATH, woodtype):
        var button = Button.new()
        button.text = "%.2f m" % woodlength
        button.icon = ICON
        button.pressed.connect(_button_pressed.bind(button))
        $VBoxContainer/ScrollContainer/VBoxContainer.add_child(button)


func _button_pressed(button: Button) -> void:
    length_selected.emit(woodtype, float(button.text))


func get_woodlengths(file_path: String, woodtype_: String) -> Array:    
    var file = FileAccess.open(file_path, FileAccess.READ)
    var result = []   
    
    if file:
        # find the wood type
        while file.get_position() < file.get_length():
            var line = file.get_line()
            if line.begins_with(woodtype_):
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
