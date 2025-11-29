extends Node2D

const TITLE_SCENE = preload("res://scenes/title.tscn")
const SESSION_SCENE = preload("res://scenes/session.tscn")
const TYPE_SCENE = preload("res://scenes/type_options.tscn")
const LENGTH_SCENE = preload("res://scenes/length_options.tscn")
const WORKSPACE_SCENE = preload("res://scenes/cube_workspace.tscn")
const REPORT_SCENE = preload("res://scenes/report.tscn")

var scene: Node = null
@onready var hud: Hud = $Hud

func _ready() -> void:
    scene = TITLE_SCENE.instantiate()
    hud.change_screen(scene)
    hud.enable_forward()
    hud.forward.connect(_on_new_session_started)
    scene.restore_session.connect(_on_show_session)

func _on_new_session_started() -> void:
    scene = SESSION_SCENE.instantiate()    
    hud.change_screen(scene)
    hud.enable_backward()
    hud.forward.connect(_on_session_submitted)
    hud.backward.connect(_ready) 
    scene.check.connect(_on_check)

func _on_show_session(session: Dictionary) -> void:
    scene = SESSION_SCENE.instantiate()
    CurrentPile.set_session_data(session)
    hud.change_screen(scene)
    scene.set_session()
    hud.enable_forward()
    hud.enable_backward()
    hud.forward.connect(_on_continue_session)
    hud.backward.connect(_ready)
    scene.check.connect(_on_check)
    
func _on_session_submitted() -> void:
    scene = TYPE_SCENE.instantiate()
    hud.change_screen(scene)
    hud.enable_backward()
    hud.backward.connect(_on_show_incomplete_session)
    scene.type_selected.connect(_on_type_selected)

func _on_show_incomplete_session() -> void:
    scene = SESSION_SCENE.instantiate()
    hud.change_screen(scene)
    scene.set_session()
    hud.enable_forward()
    hud.enable_backward()
    hud.forward.connect(_on_session_submitted)
    hud.backward.connect(_ready)
    scene.check.connect(_on_check)    

func _on_type_selected(type: String) -> void:
    scene = LENGTH_SCENE.instantiate()
    CurrentPile.type = type
    hud.change_screen(scene)
    scene.length_selected.connect(_on_length_selected)

func _on_length_selected(length: float) -> void:
    scene = WORKSPACE_SCENE.instantiate()
    CurrentPile.length = length
    CurrentPile.init()
    hud.change_screen(scene)
    hud.enable_forward()
    hud.forward.connect(_on_cube_done)

func _on_cube_done() -> void:
    scene = REPORT_SCENE.instantiate()
    hud.change_screen(scene)
    hud.enable_all()
    hud.forward.connect(_ready)
    hud.backward.connect(_ready)

func _on_continue_session() -> void:
    scene = WORKSPACE_SCENE.instantiate()
    hud.change_screen(scene)
    hud.enable_forward()
    hud.forward.connect(_on_cube_done)

func _on_check() -> void:
    if CurrentPile.is_valid():
        hud.enable_forward()
    else:
        hud.disable_forward()
