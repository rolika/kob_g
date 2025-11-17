extends Node2D

const RESTORE_SCENE = preload("res://scenes/restore.tscn")
const SESSION_SCENE = preload("res://scenes/session.tscn")
const TYPE_SCENE = preload("res://scenes/type_options.tscn")
const LENGTH_SCENE = preload("res://scenes/length_options.tscn")
const WORKSPACE_SCENE = preload("res://scenes/cube_workspace.tscn")
const REPORT_SCENE = preload("res://scenes/report.tscn")

var scene: Node = null
@onready var hud: MarginContainer = $Hud

func _ready() -> void:
    scene = RESTORE_SCENE.instantiate()
    hud.add(scene)
    hud.header_backward_button.disabled = true
    hud.footer_backward_button.disabled = true
    hud.forward.connect(_on_new_session_started)
    scene.restore_session.connect(_on_show_session)

func _on_new_session_started() -> void:
    hud.forward.disconnect(_on_new_session_started)
    scene = SESSION_SCENE.instantiate()    
    hud.add(scene)
    hud.header_forward_button.disabled = true
    hud.footer_forward_button.disabled = true
    hud.forward.connect(_on_session_submitted)    
    scene.check.connect(_on_check)
    
func _on_session_submitted() -> void:
    hud.forward.disconnect(_on_session_submitted)    
    hud.header_forward_button.disabled = true
    hud.footer_forward_button.disabled = true
    scene = TYPE_SCENE.instantiate()
    hud.add(scene)
    scene.type_selected.connect(_on_type_selected)

func _on_type_selected(type: String) -> void:
    hud.header_forward_button.disabled = true
    hud.footer_forward_button.disabled = true
    scene = LENGTH_SCENE.instantiate()
    CurrentPile.type = type
    hud.add(scene)
    scene.length_selected.connect(_on_length_selected)

func _on_length_selected(length: float) -> void:
    hud.header_backward_button.disabled = true
    hud.footer_backward_button.disabled = true
    hud.header_forward_button.disabled = false
    hud.footer_forward_button.disabled = false
    hud.forward.connect(_on_cube_done)
    scene = WORKSPACE_SCENE.instantiate()
    CurrentPile.length = length
    CurrentPile.init()
    hud.add(scene)
    scene.set_position(Vector2(0, 0))

func _on_cube_done() -> void:
    hud.header_forward_button.disabled = false
    hud.footer_forward_button.disabled = false
    hud.header_backward_button.disabled = false
    hud.footer_backward_button.disabled = false
    hud.forward.disconnect(_on_cube_done)
    hud.forward.connect(_ready)
    hud.backward.connect(_ready)
    scene = REPORT_SCENE.instantiate()
    hud.add(scene)

func _on_show_session(session: Dictionary) -> void:
    hud.header_forward_button.disabled = false
    hud.footer_forward_button.disabled = false
    hud.header_backward_button.disabled = false
    hud.footer_backward_button.disabled = false
    hud.forward.connect(_on_continue_session)
    scene = SESSION_SCENE.instantiate()
    CurrentPile.set_session_data(session)
    hud.add(scene)
    scene.set_session()

func _on_continue_session() -> void:
    hud.header_backward_button.disabled = true
    hud.footer_backward_button.disabled = true
    hud.header_forward_button.disabled = false
    hud.footer_forward_button.disabled = false
    hud.forward.disconnect(_on_continue_session)
    hud.forward.connect(_on_cube_done)
    scene = WORKSPACE_SCENE.instantiate()
    hud.add(scene)

func _on_check() -> void:
    if CurrentPile.is_valid():
        hud.header_forward_button.disabled = false
        hud.footer_forward_button.disabled = false
    else:
        hud.header_forward_button.disabled = true
        hud.footer_forward_button.disabled = true
