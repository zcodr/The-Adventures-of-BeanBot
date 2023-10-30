extends CanvasLayer

var death_screen : bool = true # whether death screen animation has been played true = no, false = yes
var win_screen : bool = true # whether win screen animation has been played true = no, false = yes

func _process(_delta):
	$HealthBar.value = Global.player_health
	$Gold.text = str(Global.player_money) + ": Gold"
	
	if Global.player_dead and death_screen:
		$AnimationPlayer.play("DeathScreen")
		$ShopScreen.visible = false
		get_tree().paused = true
		death_screen = false
	
	if Global.player_won and win_screen:
		$AnimationPlayer.play("WinScreen")
		%Label2.text = "you got: " + str(Global.player_won_gold) + " gold"
		$ShopScreen.visible = false
		get_tree().paused = true
		win_screen = false
	
	if Global.player_money >= 3 and !Global.upgrades["faster shooting"]:
		%FasterShooting.disabled = false
	else:
		%FasterShooting.disabled = true
	
	if Global.player_money >= 3 and !Global.upgrades["more projectiles"]:
		%MoreProjectiles.disabled = false
	else:
		%MoreProjectiles.disabled = true
		
	if Global.player_money >= 3 and !Global.upgrades["greater damage"]:
		%GreaterDamage.disabled = false
	else:
		%GreaterDamage.disabled = true
	
	if Global.player_money >= 6 and !Global.upgrades["machine gun"] and !Global.upgrades["shotgun"] and !Global.upgrades["rifle"] and Global.upgrades["faster shooting"]:
		%MachineGun.disabled = false
	else:
		%MachineGun.disabled = true

	if Global.player_money >= 6 and !Global.upgrades["machine gun"] and !Global.upgrades["shotgun"] and !Global.upgrades["rifle"] and Global.upgrades["more projectiles"]:
		%ShotGun.disabled = false
	else:
		%ShotGun.disabled = true

	if Global.player_money >= 6 and !Global.upgrades["machine gun"] and !Global.upgrades["shotgun"] and !Global.upgrades["rifle"] and Global.upgrades["greater damage"]:
		%Rifle.disabled = false
	else:
		%Rifle.disabled = true

	if Global.player_money >= 9 and !Global.upgrades["mini gun"] and !Global.upgrades["shotgun"] and !Global.upgrades["rifle"] and Global.upgrades["faster shooting"] and Global.upgrades["machine gun"]:
		%MiniGun.disabled = false
	else:
		%MiniGun.disabled = true

	if Global.player_money >= 9 and !Global.upgrades["pump shotgun"] and !Global.upgrades["machine gun"] and !Global.upgrades["rifle"] and Global.upgrades["more projectiles"] and Global.upgrades["shotgun"]:
		%PumpShotGun.disabled = false
	else:
		%PumpShotGun.disabled = true

	if Global.player_money >= 9 and !Global.upgrades["bazooka"] and !Global.upgrades["machine gun"] and !Global.upgrades["shotgun"] and Global.upgrades["greater damage"] and Global.upgrades["rifle"]:
		%Bazooka.disabled = false
	else:
		%Bazooka.disabled = true

func _on_retry_battle_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()
	Global.player_dead = false

func _on_return_to_world_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/Game.tscn")
	Global.player_dead = false
	Global.player_won = false
	Global.player_won_gold = 0

func _on_faster_shooting_pressed():
	Global.upgrades["faster shooting"] = true
	Global.player_money -= 3

func _on_more_projectiles_pressed():
	Global.upgrades["more projectiles"] = true
	Global.player_money -= 3

func _on_greater_damage_pressed():
	Global.upgrades["greater damage"] = true
	Global.player_money -= 3
	
func _on_machine_gun_pressed():
	Global.upgrades["machine gun"] = true
	Global.player_money -= 6
	
func _on_shot_gun_pressed():
	Global.upgrades["shotgun"] = true
	Global.player_money -= 6
	
func _on_rifle_pressed():
	Global.upgrades["rifle"] = true
	Global.player_money -= 6
	
func _on_mini_gun_pressed():
	Global.upgrades["mini gun"] = true
	Global.player_money -= 9
	
func _on_pump_shot_gun_pressed():
	Global.upgrades["pump shotgun"] = true
	Global.player_money -= 9
	
func _on_bazooka_pressed():
	Global.upgrades["bazooka"] = true
	Global.player_money -= 9

func _on_shop_button_pressed():
	$AnimationPlayer.play("ShopScreen")
	get_tree().paused = true

func _on_close_shop_pressed():
	$AnimationPlayer.play_backwards("ShopScreen")
	get_tree().paused = false
