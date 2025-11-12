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
    if scene != null:
        remove_prev_scene()
    scene = RESTORE_SCENE.instantiate()
    hud.add(scene)
    hud.forward.connect(_on_new_session_started)
    scene.restore_session.connect(_on_show_session)

func _on_new_session_started() -> void:
    scene = SESSION_SCENE.instantiate()    
    hud.add(scene)
    hud.header_forward_button.disabled = true
    hud.footer_forward_button.disabled = true
    hud.forward.connect(_on_session_submitted)    
    scene.completed.connect(_on_completed)
    
func _on_session_submitted() -> void:
    remove_prev_scene()
    scene = TYPE_SCENE.instantiate()
    add_child(scene)
    scene.type_selected.connect(_on_type_selected)

func _on_type_selected(type: String) -> void:
    remove_prev_scene()
    scene = LENGTH_SCENE.instantiate()
    CurrentPile.type = type
    add_child(scene)
    scene.length_selected.connect(_on_length_selected)

func _on_length_selected(length: float) -> void:
    remove_prev_scene()
    scene = WORKSPACE_SCENE.instantiate()
    CurrentPile.length = length
    CurrentPile.init()
    add_child(scene)
    scene.done.connect(_on_cube_done)
    scene.set_position(Vector2(0, 0))

func _on_cube_done() -> void:
    remove_prev_scene()
    scene = REPORT_SCENE.instantiate()
    add_child(scene)
    scene.back.connect(_ready)

func _on_show_session(session: Dictionary) -> void:
    remove_prev_scene()
    scene = SESSION_SCENE.instantiate()
    CurrentPile.set_session_data(session)
    add_child(scene)
    scene.set_session()
    scene.submit.connect(_on_continue_session)

func remove_prev_scene() -> void:
    remove_child(scene)
    scene.queue_free()

func _on_continue_session() -> void:    
    remove_prev_scene()
    scene = WORKSPACE_SCENE.instantiate()
    add_child(scene)
    scene.done.connect(_on_cube_done)

func _on_completed() -> void:
    if CurrentPile.is_valid():
        hud.header_forward_button.disabled = false
        hud.footer_forward_button.disabled = false
    else:
        hud.header_forward_button.disabled = true
        hud.footer_forward_button.disabled = true
