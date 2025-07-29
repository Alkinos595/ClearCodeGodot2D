extends LevelParent

#@export var outside_level_scene: PackedScene = preload("res://scenes/levels/outside.tscn")

func change_scene_to_outside():
	TransitionLayer.change_scene("res://scenes/levels/outside.tscn")

func _on_exit_gate_area_body_entered(_body: Node2D) -> void:
	var tween = create_tween()
	tween.tween_property($Player, "speed", 0, 0.5)
	call_deferred("change_scene_to_outside")
	#get_tree().change_scene_to_packed(outside_level_scene)
