extends MarginContainer

signal backward
signal forward
signal home

var screen: Container = null

@onready var header_backward_button: Button = $VBoxContainer/HeaderContainer/BackwardButton
@onready var header_forward_button: Button = $VBoxContainer/HeaderContainer/ForwardButton
@onready var footer_backward_button: Button = $VBoxContainer/FooterContainer/BackwardButton
@onready var footer_forward_button: Button = $VBoxContainer/FooterContainer/ForwardButton

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

func add(content: Container) -> void:
    if screen != null:
        screen.call_deferred("free")
    screen = content
    $VBoxContainer/ContentContainer.add_child(screen)
