extends CharacterBody2D

@export var speed : float
@export var health : float

var BulletScene : PackedScene = preload("res://Scenes/Bullet.tscn")
var can_shoot : bool = true

func _ready():
	$AttackCooldown.wait_time = 0.5
	if Global.upgrades["faster shooting"]:
		$AttackCooldown.wait_time = 0.333
	if Global.upgrades["machine gun"]:
		$AttackCooldown.wait_time = 0.25
	if Global.upgrades["mini gun"]:
		$AttackCooldown.wait_time = 0.1
	if get_tree().current_scene.name == "Game":
		global_position = Global.player_pos

func _physics_process(_delta):
	Global.player_health = health
	velocity = Vector2.ZERO
	if !Global.player_dead:
		if Input.is_action_pressed("Up"):
			velocity.y -= 1
		if Input.is_action_pressed("Down"):
			velocity.y += 1
		if Input.is_action_pressed("Left"):
			velocity.x -= 1
		if Input.is_action_pressed("Right"):
			velocity.x += 1
		look_at(get_global_mouse_position())
		velocity = velocity.normalized() * speed
		move_and_slide()
		
		if Input.is_action_pressed("Attack") && can_shoot:
			can_shoot = false
			var projectiles : int = 1
			if Global.upgrades["more projectiles"]:
				projectiles = 2
			if Global.upgrades["shotgun"]:
				projectiles = 4
			if Global.upgrades["pump shotgun"]:
				projectiles = 8
			for i in range(projectiles):
				var new_bullet : CharacterBody2D = BulletScene.instantiate()
				get_tree().current_scene.add_child(new_bullet)
				new_bullet.global_position = global_position
				if projectiles == 1:
					new_bullet.shoot(global_position.direction_to(get_global_mouse_position()))
				if projectiles == 2:
					new_bullet.shoot(global_position.direction_to(get_global_mouse_position()).rotated(-PI/24+ i * PI/12))
				if projectiles == 4:
					new_bullet.shoot(global_position.direction_to(get_global_mouse_position()).rotated(-PI/8+ i * PI/12))
				if projectiles == 8:
					new_bullet.shoot(global_position.direction_to(get_global_mouse_position()).rotated(-PI/12 + i * PI/48))
			$AttackCooldown.start()

func takedamage():
	health -= 1
	print("player health: ", health)
	if (health <= 0):
		$DeathTimer.start()
		$DeathParticles.emitting = true
		$AnimationPlayer.play("DeathAnimation")
		$CollisionShape2D.set_deferred("disabled", true)

func _on_death_timer_timeout():
	Global.player_dead = true
	$Sprite2D.visible = false
	$CollisionShape2D.set_deferred("disabled", true)

func _on_walk_sfx_timer_timeout():
	if velocity == Vector2.ZERO:
		$WalkSFX.stop()
	else:
		$WalkSFX.play()

func _on_attack_cooldown_timeout():
	can_shoot = true
