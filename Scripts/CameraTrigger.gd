extends Area2D

@export var camera : Camera2D

func _on_body_entered(body : Node2D):
	if body.scene_file_path == "res://Scenes/Player.tscn":
		camera.enabled = true
		camera.make_current()
