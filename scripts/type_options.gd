extends ScrollContainer

const ICON: CompressedTexture2D = preload("res://assets/icons/tree_icon.png")
const PINE_ICON: CompressedTexture2D = preload("res://assets/icons/pine_icon.png")
signal type_selected(type: String)

func _ready() -> void:
    for woodtype in File_IO.get_woodtypes():
        var button = Button.new()
        button.text = woodtype
        if "fenyő" in woodtype:
            button.icon = PINE_ICON
        else:
            button.icon = ICON
        button.vertical_icon_alignment = VERTICAL_ALIGNMENT_TOP
        button.icon_alignment = HORIZONTAL_ALIGNMENT_CENTER
        button.custom_minimum_size = Vector2(240, 200)
        button.mouse_filter = Control.MOUSE_FILTER_PASS
        button.pressed.connect(_button_pressed.bind(button))
        $VBoxContainer.add_child(button)

func _button_pressed(button: Button) -> void:
    type_selected.emit(button.text)
