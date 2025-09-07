extends Control


const ICON: CompressedTexture2D = preload("res://icon.svg")


@export var woodtype: String = "bükk"


signal length_selected(type: String, length: float)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    for woodlength in File_IO.get_woodlengths(woodtype):
        var button = Button.new()
        button.text = "%.2f m" % woodlength
        button.icon = ICON
        button.pressed.connect(_button_pressed.bind(button))
        $VBoxContainer/ScrollContainer/VBoxContainer.add_child(button)


func _button_pressed(button: Button) -> void:
    length_selected.emit(woodtype, float(button.text))
