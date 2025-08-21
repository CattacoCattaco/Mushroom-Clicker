class_name Tile
extends Node2D

@export var mushroom_scene: PackedScene
@export var button: TextureButton

var pos: Vector2i
var mushroom: Mushroom
var game: Game

var disabled: bool = false:
	get:
		return disabled
	set(new_value):
		disabled = new_value
		if new_value:
			button.hide()
		else:
			button.show()


func _ready() -> void:
	button.pressed.connect(_button_pressed)


func _button_pressed() -> void:
	add_mushroom(SporesScorecard.SporeType.RED_BASIC)


func add_mushroom(type: SporesScorecard.SporeType, big: bool = false) -> void:
	mushroom = mushroom_scene.instantiate()
	add_child(mushroom)
	
	mushroom.pos = pos
	mushroom.position = Vector2(0, 0)
	
	mushroom.type = type
	mushroom.big = big
	
	mushroom.game = game
	
	if big:
		for x in range(2):
			for y in range(2):
				game.mushroom_grid_manager.big_mushroom_tiles.set_bit(pos.x + x, pos.y + y, true)
				
				var covered_tile: Tile = game.mushroom_grid_manager.tiles[pos.x + x][pos.y + y]
				covered_tile.disabled = true
	else:
		game.mushroom_grid_manager.mushroom_tiles.set_bit(pos.x, pos.y, true)


func remove_mushroom() -> void:
	if mushroom.big:
		for x in range(2):
			for y in range(2):
				game.mushroom_grid_manager.big_mushroom_tiles.set_bit(pos.x + x, pos.y + y, false)
				
				var covered_tile: Tile = game.mushroom_grid_manager.tiles[pos.x + x][pos.y + y]
				covered_tile.disabled = false
	else:
		game.mushroom_grid_manager.mushroom_tiles.set_bit(pos.x, pos.y, false)
	
	mushroom.queue_free()
	mushroom = null
