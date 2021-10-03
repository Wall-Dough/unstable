extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# time in minutes
var time = 60 * 17
var time_speed = 10
var max_time = 24 * 60


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

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

func display_time():
	var am_pm = "AM"
	var hours = floor(time / 60)
	if hours >= 12:
		am_pm = "PM"
	if hours == 0:
		hours = 12
	if hours > 12:
		hours -= 12
	var minutes = int(time) % 60
	$time/hours.set_text("%02d" % hours)
	$time/minutes.set_text("%02d" % minutes)
	$time/am_pm.set_text(am_pm)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time += delta * time_speed
	if time >= max_time:
		time = 0
	display_time()
