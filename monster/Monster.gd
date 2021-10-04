extends Node2D

signal bed_time

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var active_sprite
var rage_level = 0
var max_rage = 100
var rage_speed = 20
var superrage_speed = 20
var superrage_level = 0
var effectiveness = float(30)
var enraged = false
var asleep = false
var atk_factor = 3
var effects = {
	"feed": {
		"cur": effectiveness,
		"max": effectiveness,
	},
	"pet": {
		"cur": effectiveness,
		"max": effectiveness,
	},
	"left_punch": {
		"cur": effectiveness / atk_factor,
		"max": effectiveness / atk_factor,
	},
	"right_punch": {
		"cur": effectiveness / atk_factor,
		"max": effectiveness / atk_factor,
	},
	"left_kick": {
		"cur": effectiveness / atk_factor,
		"max": effectiveness / atk_factor,
	},
	"right_kick": {
		"cur": effectiveness / atk_factor,
		"max": effectiveness / atk_factor,
	},
}
var growth = 2
var decay = 5
var bed_time = 22 * 60 # 10 PM


# Called when the node enters the scene tree for the first time.
func _ready():
	active_sprite = $body/collision/sprite/rest

func set_bed_time(hour, minute):
	bed_time = hour * 60
	bed_time += minute

func set_effect(effect, value):
	effects[effect]["cur"] = value
	effects[effect]["max"] = value

func set_rage_speed(rage_speed):
	self.rage_speed = rage_speed

func set_max_rage(max_rage):
	self.max_rage = max_rage

func get_root():
	return get_tree().get_current_scene()

func calc_decay(action):
	effects[action]["cur"] -= decay
	if effects[action]["cur"] < 0:
		effects[action]["cur"] = 0
	calc_growth()

func calc_growth():
	for action in effects:
		effects[action]["cur"] += growth
		if effects[action]["cur"] > effects[action]["max"]:
			effects[action]["cur"] = effects[action]["max"]

func change_sprite(sprite):
	active_sprite.hide()
	active_sprite = sprite
	active_sprite.show()

func enrage():
	if asleep:
		return
	enraged = true
	$body.set_moving(true)
	get_root().set_combat_mode(true)
	change_sprite($body/collision/sprite/enraged)

func superenrage():
	get_tree().change_scene("res://failure/Failure.tscn")

func rest():
	if asleep:
		return
	enraged = false
	$body.set_moving(false)
	get_root().set_combat_mode(false)
	change_sprite($body/collision/sprite/rest)

func sleep():
	if enraged or asleep:
		return
	asleep = true
	change_sprite($body/collision/sprite/asleep)
	emit_signal("bed_time")

func perform(action):
	if asleep:
		return
	rage_level -= effects[action]["cur"]
	if rage_level < 0:
		rage_level = 0
		rest()
	calc_decay(action)

func can_perform(action):
	return effects[action]["cur"] > 0

func feed():
	if enraged or asleep:
		return
	perform("feed")

func pet():
	if enraged or asleep:
		return
	perform("pet")

func left_punch():
	if !enraged or asleep:
		return
	perform("left_punch")

func right_punch():
	if !enraged or asleep:
		return
	perform("right_punch")

func left_kick():
	if !enraged or asleep:
		return
	perform("left_kick")

func right_kick():
	if !enraged or asleep:
		return
	perform("right_kick")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if asleep:
		return
	if enraged:
		superrage_level += delta * superrage_speed
		if superrage_level >= max_rage:
			superrage_level = max_rage
			superenrage()
	else:
		superrage_level = 0
		rage_level += delta * rage_speed
		if rage_level >= max_rage:
			rage_level = max_rage
			enrage()
	rage_level = float(rage_level)
	var max_rage_size = $body/max_rage.get_size().x
	var rage_size = rage_level / max_rage * max_rage_size
	var superrage_size = superrage_level / max_rage * max_rage_size
	$body/max_rage/rage_level.rect_size.x = rage_size
	$body/max_rage/superrage_level.rect_size.x = superrage_size
	get_root().set_effectivenesses(effects)


func _on_time_time_change(time):
	if enraged or asleep:
		return
	if time >= bed_time:
		sleep()
