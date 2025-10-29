extends Window

signal confirmed
    
func set_new_title(title_text: String) -> void:
    title = title_text

func set_new_message(message_text) -> void:
    $MessageLabel.text = message_text

func _on_cancel_button_pressed() -> void:
    call_deferred("free")

func _on_close_requested() -> void:
    call_deferred("free")

func _on_ok_button_pressed() -> void:
    confirmed.emit()
    call_deferred("free")
