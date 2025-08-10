extends CharacterBody2D

var player_nearby: bool = false
var can_laser: bool = true
var switch_gun: bool = false
var can_damage:bool = true
var health: int = 30

signal laser(pos, direction)

func _on_hit_timer_timeout() -> void:
	can_damage = true
	$Sprite2D.material.set_shader_parameter("progress", 0)

func hit():
	$Timers/HitTimer.start()
	if can_damage == true:
		health -= 10
		can_damage = false
		$Sprite2D.material.set_shader_parameter("progress", 1)
		$HitSound.play()
	if health <= 0:
		queue_free()

func _process(_delta: float) -> void:
	if player_nearby:
		look_at(Globals.player_pos)
		if can_laser:
			var direction: Vector2 =(Globals.player_pos - position).normalized()
			var pos: Vector2
			if switch_gun == false:
				pos = $LaserSpawnPositions/Marker1.global_position
			else:
				pos = $LaserSpawnPositions/Marker2.global_position
			laser.emit(pos, direction)
			can_laser = false
			$Timers/LaserTimer.start()

func _on_attack_area_body_entered(_body: Node2D) -> void:
	player_nearby = true

func _on_attack_area_body_exited(_body: Node2D) -> void:
	player_nearby = false

func _on_laser_timer_timeout() -> void:
	can_laser = true
	if switch_gun == false:
		switch_gun = true
	else:
		switch_gun = false
