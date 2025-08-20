@tool
class_name Mushroom
extends Sprite2D

@export var spores_scorecard: SporesScorecard

@export var is_big: bool = false:
	get:
		return is_big
	set(value):
		is_big = value
		update_sprite()

@export var type: SporesScorecard.SporeType = SporesScorecard.SporeType.RED_BASIC:
	get:
		return type
	set(value):
		type = value
		update_sprite()

@export var timer: Timer
@export var texture_button: TextureButton

var payout_amount: int = 1
var seconds_per_payout: float = 1.0


func _ready() -> void:
	if not Engine.is_editor_hint():
		if is_big:
			texture_button.pressed.connect(payout)
		else:
			timer.timeout.connect(payout)
			timer.wait_time = seconds_per_payout
			timer.start()


func update_sprite() -> void:
	var prefix: String = "big_" if is_big else ""
	
	var color_name: String = SporesScorecard.SPORE_COLOR_NAMES[type].to_lower()
	prefix += color_name
	
	texture = load("res://game/spores/shrooms/%s_mushroom.png" % prefix)
	
	if is_big:
		var click_mask := BitMap.new()
		click_mask.create_from_image_alpha(texture.get_image())
		texture_button.texture_click_mask = click_mask
		texture_button.show()
	else:
		texture_button.hide()


func payout() -> void:
	spores_scorecard.spore_counts[type] += payout_amount
	spores_scorecard.display_counts()
