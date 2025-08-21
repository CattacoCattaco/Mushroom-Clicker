class_name MushroomGridManager
extends Node2D

const GRID_SIZE: int = 100

@export var tile_scene: PackedScene
@export var game: Game

var mushroom_tiles := BitMap.new()
var big_mushroom_tiles := BitMap.new()

var tiles: Array[Array] = []


func _ready() -> void:
	mushroom_tiles.create(Vector2i(GRID_SIZE, GRID_SIZE))
	big_mushroom_tiles.create(Vector2i(GRID_SIZE, GRID_SIZE))
	
	for x in range(GRID_SIZE):
		tiles.append([])
		for y in range(GRID_SIZE):
			var tile: Tile = tile_scene.instantiate()
			
			tiles[x].append(tile)
			add_child(tile)
			
			tile.pos = Vector2i(x, y)
			tile.position = Vector2(x - (GRID_SIZE >> 1), y - (GRID_SIZE >> 1)) * 16
			tile.game = game
	
	print(GRID_SIZE >> 1)
	print("done")
	
	var big_mushroom_tile: Tile = tiles[(GRID_SIZE >> 1) - 1][(GRID_SIZE >> 1) - 1]
	big_mushroom_tile.add_mushroom(SporesScorecard.SporeType.RED_BASIC, true)
