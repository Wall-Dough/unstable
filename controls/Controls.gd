extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func show_combat():
	$non_combat.hide()
	$combat.show()

func show_non_combat():
	$combat.hide()
	$non_combat.show()

func set_effectivenesses(effects):
	for action in effects:
		var label = find_node(action)
		var max_bar = label.get_child(0)
		var cur_bar = max_bar.get_child(0)
		var max_size = max_bar.get_size().y
		var cur_effect = float(effects[action]["cur"])
		var max_effect = float(effects[action]["max"])
		cur_bar.rect_size.y = cur_effect / max_effect * max_size

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
