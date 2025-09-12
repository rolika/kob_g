extends VBoxContainer


const ICON: CompressedTexture2D = preload("res://icon.svg")


signal type_selected(type: String)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    for woodtype in File_IO.get_woodtypes():
        var button = Button.new()
        button.text = woodtype
        button.icon = ICON
        button.vertical_icon_alignment = VERTICAL_ALIGNMENT_TOP
        button.icon_alignment = HORIZONTAL_ALIGNMENT_CENTER
        button.pressed.connect(_button_pressed.bind(button))
        $ScrollContainer/VBoxContainer.add_child(button)


func _button_pressed(button: Button) -> void:
    type_selected.emit(button.text)
