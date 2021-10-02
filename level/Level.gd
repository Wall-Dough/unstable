extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func get_player():
	return $Player
	
func get_monster():
	return $Monster

func play_jump():
	$Sounds/jump.play()

func play_hit_hurt():
	$Sounds/hit_hurt.play()

func play_feed():
	$Sounds/feed.play()

func play_pet():
	$Sounds/pet.play()

func set_combat_mode(combat_mode):
	$Player.set_combat_mode(combat_mode)
	if combat_mode:
		$Controls.show_combat()
	else:
		$Controls.show_non_combat()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
