extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export(int, 23) var start_hour = 17
export(int, 59) var start_minute = 0
export(int, 23) var bed_time_hour = 22
export(int, 59) var bed_time_minute = 0
export(int, 30) var pet_effect = 30
export(int, 30) var feed_effect = 30
export(int, 30) var attack_effect = 10
export(PackedScene) var next_level

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	$time.set_time(start_hour, start_minute)
	$Monster.set_bed_time(bed_time_hour, bed_time_minute)
	$Monster.set_effect("pet", pet_effect)
	$Monster.set_effect("feed", feed_effect)
	$Monster.set_effect("left_punch", attack_effect)
	$Monster.set_effect("right_punch", attack_effect)
	$Monster.set_effect("left_kick", attack_effect)
	$Monster.set_effect("right_kick", attack_effect)

func get_player():
	return $Player
	
func get_monster():
	return $Monster

func play_jump():
	$Sounds/jump.play()

func play_hit_hurt():
	$Sounds/hit_hurt.play()

func play_feed():
	$Sounds/feed.play()

func play_pet():
	$Sounds/pet.play()

func set_combat_mode(combat_mode):
	$Player.set_combat_mode(combat_mode)
	if combat_mode:
		$Controls.show_combat()
	else:
		$Controls.show_non_combat()

func set_effectivenesses(effects):
	$Controls.set_effectivenesses(effects)

func advance_level():
	if next_level == null:
		get_tree().change_scene("res://victory/Victory.tscn")
	else:
		get_tree().change_scene_to(next_level)
