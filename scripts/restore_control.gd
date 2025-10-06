extends Control

signal remove_session
signal continue_session

func _on_remove_button_pressed() -> void:
    remove_session.emit()

func _on_continue_button_pressed() -> void:
    continue_session.emit()
