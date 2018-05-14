extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
#var first = true

var previousNum = -1
var startTimer = 75
var keyCamera = false

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func _physics_process(delta):
	if startTimer > 0:
		startTimer -= 1
	else:
		if keyCamera == false:
			keyCamera = true
			var key = load("res://Scenes/Key.tscn").instance()
			randomPlacement(key)
			key.createKey()
			
		

func randomPlacement(var obj):

	add_child(obj)
	var i = previousNum
	while i == previousNum:
		randomize()
		i = randi() % 8

	previousNum = i
#	print("I value: " + str(i))
#	i = 7
	if i == 0:
#		x = 22, y = 20
		obj.position.x = 22
		obj.position.y = 20
	elif i == 1:
#		x = 905, y = 182
		obj.position.x = 905
		obj.position.y = 182
	elif i == 2:
#		x = 844, y = 42
		obj.position.x = 844
		obj.position.y = 42
	elif i == 3:
#		x = 808, y = 497
		obj.position.x = 808
		obj.position.y = 497
	elif i == 4:
#		x = 973, y = 536
		obj.position.x = 973
		obj.position.y = 536
	elif i == 5:
#		x = 476, y = 581
		obj.position.x = 476
		obj.position.y = 581
	elif i == 6:
#		x = 389, y = 555
		obj.position.x = 389
		obj.position.y = 555
	elif i == 7:
#		x = 84, y = 571
		obj.position.x = 84
		obj.position.y = 571
	
#	print("X: " + str(obj.position.x))
#	print("Y: " + str(obj.position.y))

func createPortal():
	var worldPortal = load("res://Scenes/WorldComplete.tscn").instance()
	randomPlacement(worldPortal)
	worldPortal.nextScene = "res://Scenes/Level2.tscn"
	worldPortal.createPortal()
	
