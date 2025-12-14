class_name PrecisionHBox extends HBoxContainer

@onready var label: Label = $Label
@onready var two_digit_check_button: CheckButton = $TwoDigitCheckButton
@onready var three_digit_check_button: CheckButton = $ThreeDigitCheckButton

enum {LABELING, CALCULATION}
var subject: int = LABELING

func _init(new_subject: int = LABELING) -> void:
    subject = new_subject
        
func _ready() -> void:
    if subject == LABELING:
        label.text = "Válaszd ki a rönkfelirat pontosságát:"
        two_digit_check_button.button_pressed = true
    else:
        label.text = "Válaszd ki a számítás pontosságát:"
        three_digit_check_button.button_pressed = true

func _on_two_digit_check_button_toggled(toggled_on: bool) -> void:
    if toggled_on:
        if subject == LABELING:
            CurrentPile.labeling_precision = Pile.Precision.TWO_DIGITS
        else:
            CurrentPile.calculation_precision = Pile.Precision.TWO_DIGITS
        print("labeling: ", CurrentPile.labeling_precision)
        print("calculation: ", CurrentPile.calculation_precision)

func _on_three_digit_check_button_toggled(toggled_on: bool) -> void:
    if toggled_on:
        if subject == LABELING:
            CurrentPile.labeling_precision = Pile.Precision.THREE_DIGITS
        else:
            CurrentPile.calculation_precision = Pile.Precision.THREE_DIGITS
        print("labeling: ", CurrentPile.labeling_precision)
        print("calculation: ", CurrentPile.calculation_precision)
