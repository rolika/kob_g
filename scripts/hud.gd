extends MarginContainer

signal backward
signal forward
signal home

var screen: Node2D = null

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

func add(content: Node2D) -> void:
    if screen != null:
        screen.call_deferred("free")
    screen = content
    $VBoxContainer/ContentContainer.add_child(screen)

func title_state() -> void:
    $VBoxContainer/HeaderContainer/BackwardButton.disabled = true
    $VBoxContainer/FooterContainer/BackwardButton.disabled = true
    $VBoxContainer/FooterContainer/HomeButton.disabled = true

func non_title_state() -> void:
    $VBoxContainer/HeaderContainer/BackwardButton.disabled = false
    $VBoxContainer/FooterContainer/BackwardButton.disabled = false
    $VBoxContainer/FooterContainer/HomeButton.disabled = false
    $VBoxContainer/HeaderContainer/ForwardButton.disabled = true
    $VBoxContainer/FooterContainer/ForwardButton.disabled = true
