extends StaticBody2D

@export var indeces : Array

func _process(_delta):
	for i in indeces:
		if !Global.arenas_cleared[i]:
			return
	queue_free()
