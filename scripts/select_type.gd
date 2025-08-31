extends Control


const FILEPATH: String = "res://data/kobozo.txt"
const ICON: CompressedTexture2D = preload("res://icon.svg")


@export var selected_type: String = "tölgy"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    for woodtype in get_woodtypes(FILEPATH):
        var button = Button.new()
        button.text = woodtype
        button.icon = ICON
        button.vertical_icon_alignment = VERTICAL_ALIGNMENT_TOP
        button.icon_alignment = HORIZONTAL_ALIGNMENT_CENTER
        button.pressed.connect(_button_pressed.bind(button))
        $VBoxContainer/ScrollContainer/VBoxContainer.add_child(button)


func _button_pressed(button: Button) -> void:
    selected_type = button.text


func get_woodtypes(file_path: String) -> Array:
    var file = FileAccess.open(file_path, FileAccess.READ)
    var result = []   
    
    if file:
        while file.get_position() < file.get_length():
            var line = file.get_line()
            if not line.begins_with(" "):
                line = line.trim_suffix(":")
                result.append(line)
        file.close()
                    
    return result
