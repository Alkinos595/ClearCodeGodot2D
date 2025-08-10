extends Node2D

class_name LevelParent

var laser_scene: PackedScene = preload("res://scenes/projectiles/laser.tscn")
var grenade_scene: PackedScene = preload("res://scenes/projectiles/grenade.tscn")
var item_scene: PackedScene = preload("res://scenes/items/item.tscn")

func _ready() -> void:
	for container in get_tree().get_nodes_in_group('Container'):
		container.connect("open", _on_container_opened)
	for scout in get_tree().get_nodes_in_group("Scouts"):
		scout.connect("laser", _on_scout_laser)

#func _add_item_deferred(item):
	#$Items.add_child(item)

func _on_container_opened(pos, direction):
	var item = item_scene.instantiate()
	item.position = pos
	item.direction = direction
	#call_deferred("_add_item_deferred", item)
	$Items.call_deferred('add_child', item)

func create_laser(pos, direction):
	var laser = laser_scene.instantiate() as Area2D
	# 1. update the laser position
	laser.position = pos
	laser.rotation_degrees = rad_to_deg(direction.angle()) + 90
	laser.direction = direction
	# 2. we have to move the laser
	#This change is in laser.gd
	
	# 3. I want to add the laser instance to a Node2D
	$Projectiles.add_child(laser)

func _on_player_laser(pos, direction) -> void:
	create_laser(pos, direction)
	
func _on_player_grenade(pos, direction) -> void:
	var grenade = grenade_scene.instantiate() as RigidBody2D
	grenade.position = pos
	grenade.linear_velocity = direction * grenade.SPEED
	$Projectiles.add_child(grenade)

func _on_scout_laser(pos, direction):
	create_laser(pos, direction)
