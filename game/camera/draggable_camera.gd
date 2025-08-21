class_name DraggableCamera
extends Camera2D

@export var game: Game


func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		if Input.is_action_pressed("drag_camera"):
			position -= event.relative
			
			#if position.x > game.mushroom_grid_manager
