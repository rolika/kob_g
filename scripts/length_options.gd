extends Node2D

const ICON: CompressedTexture2D = preload("res://icon.svg")
signal length_selected(length: float)

func _ready() -> void:
    for woodlength in File_IO.get_woodlengths():
        var button = Button.new()
        button.text = "%.2f m" % woodlength
        button.icon = ICON
        button.vertical_icon_alignment = VERTICAL_ALIGNMENT_TOP
        button.icon_alignment = HORIZONTAL_ALIGNMENT_CENTER
        button.custom_minimum_size = Vector2(240, 200)
        button.pressed.connect(_button_pressed.bind(button))
        $ScrollContainer/VBoxContainer.add_child(button)

func _button_pressed(button: Button) -> void:
    length_selected.emit(float(button.text))
