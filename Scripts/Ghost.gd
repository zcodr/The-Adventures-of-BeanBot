extends AnimatedSprite2D

@export var text : String = "[insert text]"

func _ready():
	$Label.text = text
	play("move")
	$Label.modulate.a = 0

func _on_player_check_body_entered(_body : PhysicsBody2D):
	$AnimationPlayer.play("TextShow");

func _on_player_check_body_exited(_body : PhysicsBody2D):
	$AnimationPlayer.play("TextHide")
