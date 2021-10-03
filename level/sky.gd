extends Polygon2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_time_time_change(time):
	var hours = int(time / 60) % 24
	if hours <= 6 or hours >= 20:
		set_color(Color.midnightblue)
	else:
		set_color(Color.skyblue)
