extends Node2D


const SELECT_TYPE = preload("res://scenes/type_options.tscn")
const SELECT_LENGTH = preload("res://scenes/select_length.tscn")
const CUBE_WORKSPACE = preload("res://scenes/cube_workspace.tscn")

var scene: Node


func _ready() -> void:
    scene = SELECT_TYPE.instantiate()
    add_child(scene)
    scene.type_selected.connect(_on_type_selected)


func _on_type_selected(type: String) -> void:
    remove_prev_scene()
    scene = SELECT_LENGTH.instantiate()
    scene.woodtype = type
    add_child(scene)
    scene.length_selected.connect(_on_length_selected)


func _on_length_selected(type: String, length: float) -> void:
    remove_prev_scene()
    scene = CUBE_WORKSPACE.instantiate()
    scene.woodtype = type
    scene.woodlength = length
    add_child(scene)
    scene.set_position(Vector2(0, 0))


func remove_prev_scene() -> void:
    remove_child(scene)
    scene.queue_free()
