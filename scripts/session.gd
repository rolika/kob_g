extends Node

signal check

func _ready() -> void:
    $VBoxContainer/CompanyLineEdit.call_deferred("grab_focus")

func _on_company_line_edit_text_changed(new_text: String) -> void:
    CurrentPile.company = new_text
    check.emit()

func _on_company_line_edit_text_submitted(new_text: String) -> void:
    CurrentPile.company = new_text
    check.emit()
    $VBoxContainer/CityLineEdit.call_deferred("grab_focus")

func _on_city_line_edit_text_changed(new_text: String) -> void:
    CurrentPile.city = new_text
    check.emit()

func _on_city_line_edit_text_submitted(new_text: String) -> void:
    CurrentPile.city = new_text
    check.emit()
    $VBoxContainer/SiteLineEdit.call_deferred("grab_focus")

func _on_site_line_edit_text_changed(new_text: String) -> void:
    CurrentPile.site = new_text
    check.emit()

func _on_site_line_edit_text_submitted(new_text: String) -> void:
    CurrentPile.site = new_text
    check.emit()
    $VBoxContainer/PersonLineEdit.call_deferred("grab_focus")

func _on_person_line_edit_text_changed(new_text: String) -> void:
    CurrentPile.person = new_text
    check.emit()

func _on_person_line_edit_text_submitted(new_text: String) -> void:
    CurrentPile.person = new_text
    check.emit()

func set_session() -> void:
    $CompanyLineEdit.clear()
    $CompanyLineEdit.insert_text_at_caret(CurrentPile.company)
    $CityLineEdit.clear()
    $CityLineEdit.insert_text_at_caret(CurrentPile.city)
    $SiteLineEdit.clear()
    $SiteLineEdit.insert_text_at_caret(CurrentPile.site)
    $PersonLineEdit.clear()
    $PersonLineEdit.insert_text_at_caret(CurrentPile.person)
