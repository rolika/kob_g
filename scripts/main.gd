extends Node2D


const CUBE_WORKSPACE = preload("res://scenes/cube_workspace.tscn")


func _ready() -> void:    
    var cube_workspace = CUBE_WORKSPACE.instantiate()
    cube_workspace.woodtype = "tölgy"
    cube_workspace.woodlength = 3.1
    add_child(cube_workspace)
    cube_workspace.set_position(Vector2(0, 0))
