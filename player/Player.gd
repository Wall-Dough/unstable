extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var active_sprite
var combat_mode = false

# Called when the node enters the scene tree for the first time.
func _ready():
	active_sprite = $body/collision/sprite/rest

func change_sprite(sprite):
	active_sprite.hide()
	active_sprite = sprite
	active_sprite.show()

func rest():
	change_sprite($body/collision/sprite/rest)

func pet():
	change_sprite($body/collision/sprite/pet)

func give():
	change_sprite($body/collision/sprite/give)

func punch_left():
	change_sprite($body/collision/sprite/punch_left)

func punch_right():
	change_sprite($body/collision/sprite/punch_right)

func kick_left():
	change_sprite($body/collision/sprite/kick_left)

func kick_right():
	change_sprite($body/collision/sprite/kick_right)

func jump():
	$body.jump()

func none_pressed():
	if combat_mode:
		if Input.is_action_pressed("punch_left"):
			return false
		if Input.is_action_pressed("punch_right"):
			return false
		if Input.is_action_pressed("kick_left"):
			return false
		if Input.is_action_pressed("kick_right"):
			return false
	else:
		if Input.is_action_pressed("give"):
			return false
		if Input.is_action_pressed("pet"):
			return false
	return true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var direction = 0
	if Input.is_action_pressed("move_left"):
		direction -= 1
	if Input.is_action_pressed("move_right"):
		direction += 1
	$body.set_direction(direction)
	if Input.is_action_just_pressed("jump"):
		jump()
	if combat_mode:
		if Input.is_action_just_pressed("punch_left"):
			punch_left()
		elif Input.is_action_just_pressed("punch_right"):
			punch_right()
		elif Input.is_action_just_pressed("kick_left"):
			kick_left()
		elif Input.is_action_just_pressed("kick_right"):
			kick_right()
		elif none_pressed():
			rest()
	else:
		if Input.is_action_just_pressed("give"):
			give()
		elif Input.is_action_just_pressed("pet"):
			pet()
		elif none_pressed():
			rest()
