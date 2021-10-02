extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var rest_sprite
var active_sprite
var combat_mode = false
var near_monster = false

# Called when the node enters the scene tree for the first time.
func _ready():
	rest_sprite = $body/collision/sprite/rest
	active_sprite = rest_sprite

func get_root():
	return get_tree().get_current_scene()

func get_monster():
	return get_root().get_monster()

func set_combat_mode(combat_mode):
	self.combat_mode = combat_mode

func change_sprite(sprite):
	active_sprite.hide()
	active_sprite = sprite
	active_sprite.show()

func rest():
	change_sprite(rest_sprite)

func walk():
	change_sprite($body.get_walk_sprite())

func pet():
	change_sprite($body/collision/sprite/pet)
	get_root().play_pet()
	get_monster().pet()

func give():
	change_sprite($body/collision/sprite/give)
	get_root().play_feed()
	get_monster().feed()

func punch_left():
	change_sprite($body/collision/sprite/punch_left)
	if near_monster:
		get_root().play_hit_hurt()
		get_monster().punch()

func punch_right():
	change_sprite($body/collision/sprite/punch_right)
	if near_monster:
		get_root().play_hit_hurt()
		get_monster().punch()

func kick_left():
	change_sprite($body/collision/sprite/kick_left)
	if near_monster:
		get_root().play_hit_hurt()
		get_monster().kick()

func kick_right():
	change_sprite($body/collision/sprite/kick_right)
	if near_monster:
		get_root().play_hit_hurt()
		get_monster().kick()

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
		if near_monster:
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
		$body.jump()
	if $body.is_jumping():
		rest_sprite = $body/collision/sprite/jump
		if none_pressed():
			rest()
	else:
		rest_sprite = $body/collision/sprite/rest
		if none_pressed():
			if direction != 0:
				walk()
			else:
				rest()
	if combat_mode:
		if Input.is_action_just_pressed("punch_left"):
			punch_left()
		elif Input.is_action_just_pressed("punch_right"):
			punch_right()
		elif Input.is_action_just_pressed("kick_left"):
			kick_left()
		elif Input.is_action_just_pressed("kick_right"):
			kick_right()
	else:
		if near_monster:
			if Input.is_action_just_pressed("give"):
				give()
			elif Input.is_action_just_pressed("pet"):
				pet()


func _on_player_detect_area_entered(area):
	if area.get_name() == "monster_detect":
		near_monster = true


func _on_player_detect_area_exited(area):
	if area.get_name() == "monster_detect":
		near_monster = false
