extends StaticBody2D
class_name ItemContainerSceneClass

@onready var current_direction: Vector2 = Vector2.DOWN.rotated(rotation)
var opened: bool = false
signal open(posicion, direction) # Usada en subclases, no se emite aquí

func kill_warning_open(): # Callate Godot
		open.emit(Vector2.ZERO, Vector2.ZERO)
