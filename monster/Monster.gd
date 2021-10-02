extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var active_sprite
var rage_level = 0
var max_rage = 100
var enraged = false


# Called when the node enters the scene tree for the first time.
func _ready():
	active_sprite = $body/collision/sprite/rest
	
func get_root():
	return get_tree().get_current_scene()

func change_sprite(sprite):
	active_sprite.hide()
	active_sprite = sprite
	active_sprite.show()

func enrage():
	enraged = true
	get_root().set_combat_mode(true)
	change_sprite($body/collision/sprite/enraged)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !enraged:
		rage_level += delta * 10
		if rage_level >= max_rage:
			rage_level = max_rage
			enrage()
	var max_rage_size = $body/max_rage.get_size().x
	var rage_size = rage_level / max_rage * max_rage_size
	$body/max_rage/rage_level.rect_size.x = rage_size
