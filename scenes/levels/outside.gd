extends LevelParent

#@export var inside_level_scene: PackedScene = preload("res://scenes/levels/inside.tscn")

func change_scene_to_inside():
	TransitionLayer.change_scene("res://scenes/levels/inside.tscn")

func _on_gate_player_entered_gate(_body: Variant) -> void:
	var tween = create_tween()
	tween.tween_property($Player, "speed", 0, 0.5)
	call_deferred("change_scene_to_inside")
	#get_tree().change_scene_to_packed(inside_level_scene)

func _on_house_player_entered() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property($Player/Camera2D, "zoom", Vector2(1,1), 1)

func _on_house_player_exited() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property($Player/Camera2D, "zoom", Vector2(0.6,0.6), 1)
