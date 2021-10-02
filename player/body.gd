extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var direction = 0
var speed = 300
var jump_speed = 600
var jumped = false
var jumping = false
var walk_cycle = 0.5
var walk_time = 0
var cycle_precision = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func set_direction(new_dir):
	if direction == new_dir:
		return
	direction = new_dir
	if direction != 0:
		$collision.transform.x.x = direction

func get_walk_sprite():
	var cycle_pos = int(walk_time * cycle_precision) % int(walk_cycle * cycle_precision)
	if cycle_pos > (walk_cycle * cycle_precision / 2):
		return $collision/sprite/walk_a
	else:
		return $collision/sprite/walk_b

func jump():
	if jumping:
		return
	jumped = true

func is_jumping():
	return jumping
	
func _integrate_forces(s):
	var lv = s.get_linear_velocity()
	lv.x = speed * direction
	if jumped:
		lv.y = -jump_speed
		jumped = false
		jumping = true
	s.set_linear_velocity(lv)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if direction != 0:
		walk_time += delta
		while (walk_time >= walk_cycle):
			walk_time -= walk_cycle

func _on_body_body_entered(body):
	if body.get_name() == "floor_body":
		jumping = false
