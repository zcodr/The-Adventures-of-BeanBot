extends CharacterBody2D

@export var speed : float

func shoot(direction_vec : Vector2):
	velocity = direction_vec.normalized() * speed
	rotate(direction_vec.angle())
	$ShootSFX.play()

func _physics_process(_delta):
	move_and_slide()

func _on_collision_check_body_entered(body : Node2D):
	if body.scene_file_path == "res://Scenes/Enemy.tscn":
		body.takedamage()
		$ExplodeSFX.play()
	$CollisionCheck/CollisionShape2D.set_deferred("disabled", true)
	$CollisionShape2D.set_deferred("disabled", true)
	$MeshInstance2D.visible = false
	$CPUParticles2D.visible = false

func _on_explode_sfx_finished():
	queue_free()
