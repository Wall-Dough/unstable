extends Label


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var failure_messages = ["better luck next time", "oof", "bye bye",
	"oops", ":'(", "no no no!!!", "you win some you lose some"]


# Called when the node enters the scene tree for the first time.
func _ready():
	set_text(failure_messages[randi() % failure_messages.size()])
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
