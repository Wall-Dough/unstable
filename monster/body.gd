extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var speed = 300
var direction = -1
var moving = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _integrate_forces(s):
	var lv = s.get_linear_velocity()
	if moving:
		lv.x = speed * direction
	else:
		lv.x = 0
	s.set_linear_velocity(lv)

func set_moving(moving):
	self.moving = moving

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_body_body_entered(body):
	print(body.get_name())
	if body.get_name() == "wall_body":
		if direction == -1:
			direction = 1
		else:
			direction = -1
		$collision.transform.x.x = -direction
