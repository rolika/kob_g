extends Node

var company: String
var city: String
var site: String
var person: String

var is_company_entered: bool = false
var is_city_entered: bool = false
var is_site_entered: bool = false
var is_person_entered: bool = false

signal submit(company: String, city: String, site: String, person: String)

func _ready() -> void:
    $CompanyLineEdit.call_deferred("grab_focus")

func _on_company_line_edit_text_changed(new_text: String) -> void:
    is_company_entered = true
    company = new_text

func _on_city_line_edit_text_changed(new_text: String) -> void:
    is_city_entered = true
    city = new_text

func _on_site_line_edit_text_changed(new_text: String) -> void:
    is_site_entered = true
    site = new_text

func _on_person_line_edit_text_changed(new_text: String) -> void:
    is_person_entered = true
    person = new_text

func _process(_delta: float) -> void:
    if is_company_entered and is_city_entered and is_site_entered and is_person_entered:
        $SubmitButton.disabled = false

func _on_submit_button_pressed() -> void:
    submit.emit(company, city, site, person)
