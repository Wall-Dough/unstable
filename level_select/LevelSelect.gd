extends Control

export(Array, PackedScene) var levels


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var defaults = {
	"description": "Pet and feed the monster until it's time for bed.",
	"start_hour": 17,
	"start_minute": 0,
	"bed_time_hour": 22,
	"bed_time_minute": 0
}
var extras = ["pet_effect", "feed_effect", "attack_effect", "rage_speed",
	"max_rage", "superrage_speed", "superrage_increase", "cooldown_percent"]

var level_idx = []
var cur_level_idx = 0

func get_time_string(hour, minute):
	var am_pm = "AM"
	if hour >= 12:
		am_pm = "PM"
	if hour == 0:
		hour = 12
	if hour > 12:
		hour -= 12
	return "%d:%02d %s" % [hour, minute, am_pm]

# Called when the node enters the scene tree for the first time.
func _ready():
	var icon = load("res://images/monster_icon_small.png")
	var icon_texture = ImageTexture.new()
	icon_texture.create_from_image(icon)
	for level in levels:
		var properties = defaults.duplicate()
		var state = level.get_state()
		for i in range(state.get_node_property_count(0)):
			var property_name = state.get_node_property_name(0, i)
			if properties.has(property_name):
				properties[property_name] = state.get_node_property_value(0, i)
			if extras.has(property_name):
				properties[property_name] = state.get_node_property_value(0, i)
		var start_text = get_time_string(properties["start_hour"], properties["start_minute"])
		start_text = "Start: %s" % start_text
		var bed_time_text = get_time_string(properties["bed_time_hour"], properties["bed_time_minute"])
		bed_time_text = "Bed Time: %s" % bed_time_text
		level_idx.append($level_list.get_item_count())
		$level_list.add_item(state.get_node_name(0), icon_texture)
		$level_list.add_item(properties["description"], null, false)
		$level_list.add_item(start_text, null, false)
		$level_list.add_item(bed_time_text, null, false)
		for extra in extras:
			if properties.has(extra):
				var extra_text = "%s: %d" % [extra.capitalize(), properties[extra]]
				$level_list.add_item(extra_text, null, false)
	$level_list.select(level_idx[cur_level_idx])


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("ui_down"):
		cur_level_idx += 1
		if cur_level_idx == level_idx.size():
			cur_level_idx = 0
		$level_list.select(level_idx[cur_level_idx])
		$level_list.ensure_current_is_visible()
	elif Input.is_action_just_pressed("ui_up"):
		cur_level_idx -= 1
		if cur_level_idx < 0:
			cur_level_idx = level_idx.size() - 1
		$level_list.select(level_idx[cur_level_idx])
		$level_list.ensure_current_is_visible()
	elif Input.is_action_just_pressed("ui_accept"):
		if get_tree().change_scene_to(levels[cur_level_idx]) != OK:
			print("Level select failed")
	elif Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()
