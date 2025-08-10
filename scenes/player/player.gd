extends CharacterBody2D

signal laser(pos: Vector2, direction:Vector2)
signal grenade (pos: Vector2, direction: Vector2)

var can_laser: bool = true
var can_grenade: bool = true

@export var max_speed: int = 500

var speed: int = max_speed

func hit():
	Globals.health -= 10

func _process(_delta: float) -> void:
	# input
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * speed
	move_and_slide()
	Globals.player_pos = global_position
	
	# rotate
	look_at(get_global_mouse_position())
	
	# laser shooting input
	var player_direction = (get_global_mouse_position() - position).normalized()
	if Input.is_action_pressed("primary action") and can_laser and Globals.laser_amount > 0:
		Globals.laser_amount -= 1
		$GPUParticles2D.emitting = true
		# randomly selected a market2D for the laser start
		var laser_markers = $LaserStartPositions.get_children()
		#var selected_laser = laser_markers[randi() % laser_markers.size()]
		var selected_laser = laser_markers[randi_range(0, laser_markers.size() - 1)]
		can_laser = false
		$LaserTimer.start()
		# emit the position we selected
		laser.emit(selected_laser.global_position, player_direction)
		
	if Input.is_action_pressed("secondary action") and can_grenade and Globals.grenade_amount > 0:
		Globals.grenade_amount  -= 1
		var grenade_markers = $GrenadeStartPositions.get_children()
		var selected_grenade = grenade_markers[randi_range(0, grenade_markers.size() - 1)]
		can_grenade = false
		$GrenadeTimer.start()
		grenade.emit(selected_grenade.global_position, player_direction)
		
func _on_laser_timer_timeout() -> void:
	can_laser = true

func _on_grenade_timer_timeout() -> void:
	can_grenade = true
