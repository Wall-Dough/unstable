extends Label


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var victory_messages = ["awwwww...", "sleep tight", "nighty night",
	"don't let the bed bugs bite", "sweet dreams", "finally", "thank god"]


# Called when the node enters the scene tree for the first time.
func _ready():
	set_text(victory_messages[randi() % victory_messages.size()])
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
