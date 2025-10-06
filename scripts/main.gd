extends Node2D

const RESTORE_SCENE = preload("res://scenes/restore.tscn")
const SESSION_SCENE = preload("res://scenes/session.tscn")
const TYPE_SCENE = preload("res://scenes/type_options.tscn")
const LENGTH_SCENE = preload("res://scenes/length_options.tscn")
const WORKSPACE_SCENE = preload("res://scenes/cube_workspace.tscn")
const REPORT_SCENE = preload("res://scenes/report.tscn")

var scene: Node

func _ready() -> void:
    scene = RESTORE_SCENE.instantiate()
    add_child(scene)
    scene.start_new_session.connect(_on_new_session_started)

func _on_new_session_started() -> void:
    remove_prev_scene()
    scene = SESSION_SCENE.instantiate()
    add_child(scene)
    scene.submit.connect(_on_session_submitted)    
    
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

func remove_prev_scene() -> void:
    remove_child(scene)
    scene.queue_free()
