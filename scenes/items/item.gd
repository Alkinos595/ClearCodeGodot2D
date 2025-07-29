extends Area2D

var rotation_speed: int = 3
var available_options = ["laser", "grenade", "health"]
var type = available_options[randi()%len(available_options)]

func _process(delta: float) -> void:
	rotation += rotation_speed * delta
