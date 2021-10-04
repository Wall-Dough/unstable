extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var speed = 300
var jump_speed = 800
var direction = -1
var moving = false
var can_jump = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _integrate_forces(s):
	var lv = s.get_linear_velocity()
	if moving:
		lv.x = speed * direction
		if can_jump:
			lv.y = -jump_speed
			can_jump = false
	else:
		lv.x = 0
	s.set_linear_velocity(lv)

func set_moving(new_moving):
	moving = new_moving

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_body_body_entered(body):
	if body.get_name() == "wall_body":
		direction = -direction
		$collision.transform.x.x = -direction
	if body.get_name() == "floor_body":
		can_jump = true
