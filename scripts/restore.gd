extends Node2D

signal start_new_session

func _ready() -> void:
    pass # Replace with function body.

func _process(_delta: float) -> void:
    pass

func _on_new_session_button_pressed() -> void:
    start_new_session.emit()
