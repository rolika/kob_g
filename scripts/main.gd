extends Node2D

const SESSION_SCENE = preload("res://scenes/session.tscn")
const TYPE_SCENE = preload("res://scenes/type_options.tscn")
const LENGTH_SCENE = preload("res://scenes/length_options.tscn")
const WORKSPACE_SCENE = preload("res://scenes/cube_workspace.tscn")

var scene: Node
var pile: Pile

func _ready() -> void:
    pile = Pile.new()
    scene = SESSION_SCENE.instantiate()
    add_child(scene)
    scene.submit.connect(_on_session_submitted)
    
func _on_session_submitted(company: String, city: String, site: String, person: String) -> void:
    remove_prev_scene()
    scene = TYPE_SCENE.instantiate()
    add_child(scene)
    scene.type_selected.connect(_on_type_selected)
    pile.company = company
    pile.city = city
    pile.site = site
    pile.person = person

func _on_type_selected(type: String) -> void:
    remove_prev_scene()
    scene = LENGTH_SCENE.instantiate()
    pile.type = type
    scene.woodtype = type
    add_child(scene)
    scene.length_selected.connect(_on_length_selected)

func _on_length_selected(type: String, length: float) -> void:
    remove_prev_scene()
    scene = WORKSPACE_SCENE.instantiate()
    pile.length = length
    scene.woodtype = type
    scene.woodlength = length
    add_child(scene)
    scene.set_position(Vector2(0, 0))

func remove_prev_scene() -> void:
    remove_child(scene)
    scene.queue_free()
