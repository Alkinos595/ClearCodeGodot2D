extends Node2D

var laser_scene: PackedScene = preload("res://scenes/projectiles/laser.tscn")
var grenade_scene: PackedScene = preload("res://scenes/projectiles/grenade.tscn")

func _on_gate_player_entered_gate(body) -> void:
	print("Player has entered gate")
	print(body)

func _on_player_laser(pos, direction) -> void:
	var laser = laser_scene.instantiate() as Area2D
	# 1. update the laser position
	laser.position = pos
	laser.rotation_degrees = rad_to_deg(direction.angle()) + 90
	laser.direction = direction
	# 2. we have to move the laser
	#This change is in laser.gd
	
	# 3. I want to add the laser instance to a Node2D
	$Projectiles.add_child(laser)

func _on_player_grenade(pos, direction) -> void:
	var grenade = grenade_scene.instantiate() as RigidBody2D
	grenade.position = pos
	grenade.linear_velocity = direction * grenade.SPEED
	$Projectiles.add_child(grenade)
