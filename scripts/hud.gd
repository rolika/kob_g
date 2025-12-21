class_name Hud extends MarginContainer

signal backward
signal forward
signal share

var screen: Container = null

@onready var header_backward_button: Button = $VBoxContainer/HeaderContainer/BackwardButton
@onready var header_forward_button: Button = $VBoxContainer/HeaderContainer/ForwardButton
@onready var footer_backward_button: Button = $VBoxContainer/FooterContainer/BackwardButton
@onready var footer_forward_button: Button = $VBoxContainer/FooterContainer/ForwardButton
@onready var share_button: Button = $VBoxContainer/FooterContainer/ShareButton

func _on_backward_button_pressed() -> void:
    backward.emit()

func _on_forward_button_pressed() -> void:
    forward.emit()

func _on_share_button_pressed() -> void:
    share.emit()

func change_screen(content: Container) -> void:
    disable_all()
    disconnect_all()
    if screen != null:
        screen.call_deferred("free")
    screen = content
    $VBoxContainer/ContentContainer.add_child(screen)

func disconnect_all() -> void:
    for connection in forward.get_connections():
        forward.disconnect(connection.callable)
    for connection in backward.get_connections():
        backward.disconnect(connection.callable)
    for connection in share.get_connections():
        share.disconnect(connection.callable)

func disable_forward() -> void:
    header_forward_button.disabled = true
    footer_forward_button.disabled = true

func disable_backward() -> void:
    header_backward_button.disabled = true
    footer_backward_button.disabled = true

func disable_all() -> void:
    disable_forward()
    disable_backward()
    share_button.disabled = true

func enable_forward() -> void:
    header_forward_button.disabled = false
    footer_forward_button.disabled = false

func enable_backward() -> void:
    header_backward_button.disabled = false
    footer_backward_button.disabled = false

func enable_all() -> void:
    enable_forward()
    enable_backward()
    share_button.disabled = false
