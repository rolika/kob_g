extends MarginContainer

signal backward
signal forward
signal home

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
    pass

func _on_backward_button_pressed() -> void:
    backward.emit()

func _on_forward_button_pressed() -> void:
    forward.emit()

func _on_home_button_pressed() -> void:
    home.emit()
