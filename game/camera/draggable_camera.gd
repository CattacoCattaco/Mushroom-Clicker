class_name DraggableCamera
extends Camera2D


func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		if Input.is_action_pressed("drag_camera"):
			position -= event.relative
