extends Node

signal submit()

func _ready() -> void:
    $CompanyLineEdit.call_deferred("grab_focus")

func _on_company_line_edit_text_changed(new_text: String) -> void:
    CurrentPile.company = new_text

func _on_city_line_edit_text_changed(new_text: String) -> void:
    CurrentPile.city = new_text

func _on_site_line_edit_text_changed(new_text: String) -> void:
    CurrentPile.site = new_text

func _on_person_line_edit_text_changed(new_text: String) -> void:
    CurrentPile.person = new_text

func _process(_delta: float) -> void:
    if CurrentPile.is_valid():
        $SubmitButton.disabled = false
    else:
        $SubmitButton.disabled = true

func _on_submit_button_pressed() -> void:
    submit.emit()
