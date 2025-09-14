extends Button

signal type_selected(type: String)

func _ready() -> void:
    self.pressed.connect(_button_pressed.bind(self))

func _button_pressed(button: Button) -> void:
    type_selected.emit(button.text)
