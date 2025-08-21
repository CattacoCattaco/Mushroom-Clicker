@tool
class_name Mushroom
extends Sprite2D

@export var big: bool = false:
	get:
		return big
	set(value):
		big = value
		update_sprite()

@export var type: SporesScorecard.SporeType = SporesScorecard.SporeType.RED_BASIC:
	get:
		return type
	set(value):
		type = value
		update_sprite()

@export var texture_button: TextureButton

var pos: Vector2i
var game: Game


func _ready() -> void:
	if not Engine.is_editor_hint():
		texture_button.pressed.connect(payout)


func update_sprite() -> void:
	var prefix: String = "big_" if big else ""
	
	var color_name: String = SporesScorecard.SPORE_COLOR_NAMES[type].to_lower()
	prefix += color_name
	
	texture = load("res://game/board_stuff/shrooms/%s_mushroom.png" % prefix)
	
	var click_mask := BitMap.new()
	click_mask.create_from_image_alpha(texture.get_image())
	texture_button.texture_click_mask = click_mask


func payout() -> void:
	var payout_amount: float = game.upgrade_manager.base_payout_amounts[type]
	
	var near_big_mushroom: bool = false
	var neighbor_count: int = 0
	var range_upper_bound: int = game.upgrade_manager.neighbor_ranges[type]
	
	for x_offset in range(-range_upper_bound, range_upper_bound + 1):
		for y_offset in range(-range_upper_bound, range_upper_bound + 1):
			if not (x_offset == 0 and y_offset == 0):
				var range_pos := pos + Vector2i(x_offset, y_offset)
				
				var grid_manager: MushroomGridManager = game.mushroom_grid_manager
				
				if grid_manager.mushroom_tiles.get_bit(range_pos.x, range_pos.y):
					neighbor_count += 1
				elif grid_manager.big_mushroom_tiles.get_bit(range_pos.x, range_pos.y):
					# If we are the big mushroom, we aren't next to the big mushroom
					near_big_mushroom = not big
	
	payout_amount += game.upgrade_manager.neighbor_add_bonuses[type] * neighbor_count
	
	if near_big_mushroom:
		payout_amount += game.upgrade_manager.neighbor_add_bonuses[type] * 1.5
		payout_amount *= game.upgrade_manager.neighbor_mult_bonuses[type]
	
	payout_amount *= game.upgrade_manager.neighbor_mult_bonuses[type] ** neighbor_count
	
	game.spores_scorecard.spore_counts[type] += roundi(payout_amount)
	game.spores_scorecard.display_counts()
