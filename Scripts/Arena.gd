extends Node2D

@export var index : int

var init_enemies : int
var once : bool = true

func _ready():
	init_enemies = $Enemies.get_child_count()

func _process(_delta):
	if once:
		if $Enemies.get_child_count() <= 0:
			Global.arenas_cleared[index] = true
			Global.player_won = true
			Global.player_won_gold = init_enemies
			Global.player_money += init_enemies
			once = false
