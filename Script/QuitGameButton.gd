extends Button

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	connect("toggled", self, "button_toggled", [self])
	
func button_toggled(toggled, target):
	if toggled == true:
		get_tree().quit()

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
