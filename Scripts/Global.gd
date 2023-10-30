extends Node

var arenas_cleared : Array = [false, false, false, false, false, false, false] # 7 so far
var player_pos : Vector2 = Vector2(753, 526)
var player_health : float = 15
var player_dead : bool = false
var player_money : float = 0

var upgrades : Dictionary = {
	"faster shooting" : false,
	"more projectiles" : false,
	"greater damage" : false,
	"machine gun" : false,
	"shotgun" : false,
	"rifle" : false,
	"mini gun" : false,
	"pump shotgun" : false,
	"bazooka" : false
}
