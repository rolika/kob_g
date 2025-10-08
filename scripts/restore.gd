extends Node2D

const RESTORE_CONTROL = preload("res://scenes/restore_control.tscn")

signal start_new_session
signal restore_session

func _ready() -> void:
    var sessions = File_IO.get_sessions()
    for session in sessions:
        var pile: Pile = Pile.new()
        pile.set_session_data(session)
        var restore_control = RESTORE_CONTROL.instantiate()
        $ScrollContainer/VBoxContainer.add_child(restore_control)
        restore_control.continue_session.connect(_on_continue_session_button_pressed.bind(session))
        restore_control.populate(pile)        

func _process(_delta: float) -> void:
    pass

func _on_new_session_button_pressed() -> void:
    start_new_session.emit()

func _on_continue_session_button_pressed(session: Dictionary) -> void:
    restore_session.emit(session)
