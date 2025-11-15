extends ScrollContainer

const RESTORE_CONTROL: PackedScene = preload("res://scenes/restore_control.tscn")
const CONFIRM_DIALOG: PackedScene = preload("res://scenes/confirm_dialog.tscn")

signal restore_session

func _ready() -> void:
    var sessions = File_IO.get_sessions()
    if sessions.size() > 1:
        sessions.sort_custom(func(s1, s2): return s1.timestamp > s2.timestamp)  # newer come first
    for session in sessions:
        var pile: Pile = Pile.new()
        pile.set_session_data(session)
        var restore_control = RESTORE_CONTROL.instantiate()
        $VBoxContainer.add_child(restore_control)
        restore_control.continue_session.connect(_on_continue_session_button_pressed.bind(session))
        restore_control.remove_session.connect(_on_remove_session_button_pressed.bind(session.index))
        restore_control.populate(pile)    

func _on_continue_session_button_pressed(session: Dictionary) -> void:
    restore_session.emit(session)

func _on_remove_session_button_pressed(index: int) -> void:
    for child in $VBoxContainer.get_children():
        if index == child.get_node("HBoxContainer/PileCard").pile.index:
            var dialog = CONFIRM_DIALOG.instantiate()
            dialog.confirmed.connect(_remove_confirmed.bind(child))
            add_child(dialog)
            dialog.popup_centered()
            dialog.show()    
            break

func _remove_confirmed(child: Node) -> void:
    child.call_deferred("free")
    File_IO.delete_session(child.get_node("HBoxContainer/PileCard").pile.index)
