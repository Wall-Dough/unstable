extends Control

signal time_change(time)

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# time in minutes
var time = 60 * 17
var time_speed = 10
var max_time = 24 * 60
var emitted = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func set_time(hour, minute):
	time = hour * 60
	time += minute
	emit_signal("time_change", floor(time))

func display_time():
	var fixed_time = int(time) % max_time
	var am_pm = "AM"
	var hours = floor(fixed_time / 60)
	if hours >= 12:
		am_pm = "PM"
	if hours == 0:
		hours = 12
	if hours > 12:
		hours -= 12
	var minutes = int(fixed_time) % 60
	$hours.set_text("%d" % hours)
	$minutes.set_text("%02d" % minutes)
	$am_pm.set_text(am_pm)
	# Emit signal every quarter hour
	if minutes % 15 == 0:
		if !emitted:
			emit_signal("time_change", floor(time))
			emitted = true
	else:
		emitted = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time += delta * time_speed
	display_time()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
