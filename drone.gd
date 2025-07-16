extends CharacterBody2D

const SPEED: int = 300
var speed_direction:int  = 1

func _ready() -> void:
	$Sprite2D.rotate(PI/2)

func _process(_delta: float) -> void:
	velocity = Vector2.RIGHT * SPEED * speed_direction
	move_and_slide()
	if position.x > 1000:
		speed_direction = -1
		$Sprite2D.rotate(PI)
	if position.x < 180:
		speed_direction = 1
		$Sprite2D.rotate(PI)

func hit():
	print("Damage")
