class_name SporesScorecard
extends Sprite2D

enum SporeType {
	RED_BASIC,
	GREEN_TOXIC,
	BLUE_MAGIC
}

const SPORE_TYPE_NAMES: Array[String] = [
	"BASIC",
	"TOXIC",
	"MAGIC"
]

const SPORE_COLOR_NAMES: Array[String] = [
	"RED",
	"GREEN",
	"BLUE"
]

@export var spore_labels: Array[Label]

var spore_counts: Array[int] = [
	0,
	0,
	0,
]


func _ready() -> void:
	display_counts()


func display_counts() -> void:
	show()
	for i in len(spore_counts):
		if spore_counts[i] != 0:
			spore_labels[i].text = "%s SPORES: %s" % [
				SPORE_TYPE_NAMES[i],
				textify_number(spore_counts[i])
			]
		else:
			spore_labels[i].text = ""
			if i == 0:
				hide()


func textify_number(num: int) -> String:
	if num < 1000:
		return str(num)
	
	# Flooring log base 10 of the number doesn't quite work due to float inaccuracies
	var order_of_magnitude: int = len(str(num)) - 1
	var comma_count: int = floori(order_of_magnitude / 3.0)
	var suffix: String
	
	match comma_count:
		1:
			suffix = "K"
		2:
			suffix = "M"
		3:
			suffix = "B"
		4:
			suffix = "T"
		5:
			suffix = "q"
		6:
			suffix = "Q"
		7:
			suffix = "s"
		8:
			suffix = "S"
		9:
			suffix = "O"
		10:
			suffix = "N"
		11:
			suffix = "D"
	
	print("%s %s %s" % [order_of_magnitude, comma_count, suffix])
	
	match order_of_magnitude - (comma_count * 3):
		0:
			var shifted: float = num as float / (10 ** (order_of_magnitude))
			
			return str(shifted).pad_decimals(3) + suffix
		1:
			var shifted: float = num as float / (10 ** (order_of_magnitude - 1))
			
			return str(shifted).pad_decimals(2) + suffix
		2:
			var shifted: float = num as float / (10 ** (order_of_magnitude - 2))
			
			return str(shifted).pad_decimals(1) + suffix
	
	return ""
