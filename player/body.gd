extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var direction = 0
var speed = 300

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func set_direction(new_dir):
	if direction == new_dir:
		return
	direction = new_dir
	
func _integrate_forces(s):
	var lv = s.get_linear_velocity()
	lv.x = speed * direction
	s.set_linear_velocity(lv)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
