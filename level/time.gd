extends Control

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
	$hours.set_text("%02d" % hours)
	$minutes.set_text("%02d" % minutes)
	$am_pm.set_text(am_pm)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time += delta * time_speed
	if time >= max_time:
		time = 0
	display_time()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
