extends RigidBody2D

const SPEED = 750

func explode():
	#$Explosion.visible = true
	$AnimationPlayer.play("Explosion")
