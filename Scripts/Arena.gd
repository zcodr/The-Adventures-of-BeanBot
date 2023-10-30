extends Node2D

@export var index : int

var init_enemies : int

func _ready():
	init_enemies = $Enemies.get_child_count()

func _process(_delta):
	if $Enemies.get_child_count() <= 0:
		Global.arenas_cleared[index] = true
		Global.player_money = init_enemies
		get_tree().change_scene_to_file("res://Scenes/Game.tscn")
