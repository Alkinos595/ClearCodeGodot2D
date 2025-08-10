extends CharacterBody2D

var active: bool = false
const MAX_SPEED = 600
var speed: int = 0
var speed_multiplier: int = 1
var vulnerable: bool = true
var health: int = 50

var explosiom_active: bool = false
	

func _ready() -> void:
	$Explosion.hide()
	$Sprite2D.show()

func _process(delta: float) -> void:
	if active:
		
		look_at(Globals.player_pos)
		var direction = (Globals.player_pos - position).normalized()
		velocity = direction * speed * speed_multiplier
		var collision = move_and_collide(velocity * delta)
		if collision:
			$AnimationPlayer.play("explosion")
			explosiom_active = true
	if explosiom_active:
		var targets = get_tree().get_nodes_in_group("Container") + get_tree().get_nodes_in_group("Entity")
		for target in targets:
			var in_range = target.global_position.distance_to(global_position) < 400
			if "hit" in target and in_range:
				target.hit()

func hit():
	if vulnerable:
		health -= 10
		vulnerable = false
		$HitTimer.start()
		$Sprite2D.material.set_shader_parameter("progress", 0.5)
		$HitSound.play()
	if health <= 0:
		explosiom_active = true
		$AnimationPlayer.play("explosion")

func stop_movement():
	speed_multiplier = 0

func _on_notice_area_body_entered(_body: Node2D) -> void:
	active = true
	var tween = create_tween()
	tween.tween_property(self, "speed", MAX_SPEED, 6)

func _on_hit_timer_timeout() -> void:
	vulnerable = true
	$Sprite2D.material.set_shader_parameter("progress", 0)
