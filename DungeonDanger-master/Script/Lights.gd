extends AnimatedSprite

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func randWaitTime():
	var d = randi() % 300 + 700
	return d

var time = randWaitTime()

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _physics_process(delta):
	if time > 0:
		time -= 1
	else:
		time = randWaitTime()
		changeLight()
	
func changeLight():
	pass
	

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
