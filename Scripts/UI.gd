extends CanvasLayer

var death_screen : bool = true # whether death screen animation has been played true = no, false = yes

func _process(_delta):
	$HealthBar.value = Global.player_health
	
	if Global.player_dead and death_screen:
		$AnimationPlayer.play("DeathScreen")
		$ShopScreen.visible = false
		get_tree().paused = true
		death_screen = false
	
	if Global.player_money >= 3 and !Global.upgrades["faster shooting"]:
		%FasterShooting.disabled = false
	else:
		%FasterShooting.disabled = true
	
#	%MoreProjectiles.disabled = true
#	%GreaterDamage.disabled = true

func _on_retry_battle_pressed():
	get_tree().reload_current_scene()
	Global.player_dead = false

func _on_return_to_world_pressed():
	get_tree().change_scene_to_file("res://Scenes/Game.tscn")
	Global.player_dead = false

func _on_faster_shooting_pressed():
	Global.upgrades["faster shooting"] = true

func _on_shop_button_pressed():
	$AnimationPlayer.play("ShopScreen")

func _on_close_shop_pressed():
	$AnimationPlayer.play_backwards("ShopScreen")
