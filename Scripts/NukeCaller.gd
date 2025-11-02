extends Node2D

var NukeScene = preload("res://Scenes/Nuke.tscn")

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("Nuke"):
		_shoot_Nuke()

func _shoot_Nuke():
	var nuke = NukeScene.instantiate()
	var mouse_pos = get_viewport().get_mouse_position()
	nuke.target = mouse_pos-position
	add_child(nuke)
