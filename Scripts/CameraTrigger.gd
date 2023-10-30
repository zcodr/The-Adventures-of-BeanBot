extends Area2D

@export var camera : Camera2D

func _process(_delta):
	if overlaps_body(camera.get_parent()):
		camera.enabled = true
		camera.make_current()
