extends CharacterBody2D

@export var speed : float
@export var health : float

var player
var player_set : bool = true # so that setting player var only happens once in process

func _ready():
	$ProgressBar.max_value = health
	$AnimatedSprite2D.play("Move")

func _physics_process(_delta):
	$ProgressBar.value = health
	if player_set:
		for i in $PlayerCheck.get_overlapping_bodies():
			if i.scene_file_path == "res://Scenes/Player.tscn":
				player = i
				$PlayerCheck/CollisionShape2D.set_deferred("disabled", true)
				player_set = false
				break
				
	if is_instance_valid(player):
		$AnimatedSprite2D.look_at(player.global_position)
		$AnimatedSprite2D.rotate(PI/2)
		velocity = (global_position.direction_to(player.global_position)).normalized() * speed
	
	move_and_slide()

func takedamage():
	var damage : float = 1
	if Global.upgrades["greater damage"]:
		damage = 2
	if Global.upgrades["rifle"]:
		damage = 3
	if Global.upgrades["bazooka"]:
		damage = 4
	health -= damage
	if (health <= 0):
		$DeathTimer.start()
		$DeathParticles.emitting = true
		$AnimationPlayer.play("DeathAnimation")
		$CollisionShape2D.set_deferred("disabled", true)
		$CollisionCheck/CollisionShape2D.set_deferred("disabled", true)
	
func _on_death_timer_timeout():
	queue_free()

func _on_attack_timer_timeout():
	if is_instance_valid(player):
		if $CollisionCheck.overlaps_body(player):
			player.takedamage()
