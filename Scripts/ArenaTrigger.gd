extends Area2D

@export var index : int
@export var color : Color

var player : PhysicsBody2D

func _ready():
	$MeshInstance2D.self_modulate = color
	$CPUParticles2D.color_ramp.set_color(0, color.darkened(0.2))
	if Global.arenas_cleared[index]:
		$CPUParticles2D.color_ramp.set_color(1, Color("00cfff"))
	$Label.modulate.a = 0

func _process(_delta):
	if is_instance_valid(player):
		if overlaps_body(player):
			if Input.is_action_just_pressed("Interact"):
				Global.player_pos = player.global_position
				get_tree().change_scene_to_file("res://Scenes/Arena" + str(index) + ".tscn")
				
func _on_body_entered(body : PhysicsBody2D):
	if body.scene_file_path == "res://Scenes/Player.tscn":
		player = body
		$AnimationPlayer.play("TextShow")

func _on_body_exited(body : PhysicsBody2D):
	if body.scene_file_path == "res://Scenes/Player.tscn":
		$AnimationPlayer.play("TextHide")
