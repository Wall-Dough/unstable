extends Node2D

signal bed_time

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var active_sprite
var rage_level = 0
var max_rage = 100
var rage_speed = 20
var effectiveness = 30
var enraged = false
var asleep = false
var effects = {
	"feed": effectiveness,
	"pet": effectiveness,
	"left_punch": effectiveness,
	"right_punch": effectiveness,
	"left_kick": effectiveness,
	"right_kick": effectiveness,
}
var growth = 2
var decay = 5
var bed_time = 22 * 60 # 10 PM


# Called when the node enters the scene tree for the first time.
func _ready():
	active_sprite = $body/collision/sprite/rest
	
func get_root():
	return get_tree().get_current_scene()

func calc_decay(action):
	effects[action] -= decay
	if effects[action] < 0:
		effects[action] = 0
	calc_growth()

func calc_growth():
	for action in effects:
		effects[action] += growth
		if effects[action] > effectiveness:
			effects[action] = effectiveness

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

func feed():
	if enraged or asleep:
		return
	rage_level -= effects["feed"]
	if rage_level < 0:
		rage_level = 0
	calc_decay("feed")

func pet():
	if enraged or asleep:
		return
	rage_level -= effects["pet"]
	if rage_level < 0:
		rage_level = 0
	calc_decay("pet")

func punch():
	if !enraged or asleep:
		return
	rage_level -= effectiveness / 3
	if rage_level <= 0:
		rage_level = 0
		rest()
	calc_decay("left_punch")

func kick():
	if !enraged or asleep:
		return
	rage_level -= effectiveness / 3
	if rage_level <= 0:
		rage_level = 0
		rest()
	calc_decay("left_kick")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if asleep:
		return
	if !enraged:
		rage_level += delta * rage_speed
		if rage_level >= max_rage:
			rage_level = max_rage
			enrage()
	rage_level = float(rage_level)
	var max_rage_size = $body/max_rage.get_size().x
	var rage_size = rage_level / max_rage * max_rage_size
	$body/max_rage/rage_level.rect_size.x = rage_size


func _on_time_time_change(time):
	if enraged or asleep:
		return
	if time >= bed_time:
		sleep()
