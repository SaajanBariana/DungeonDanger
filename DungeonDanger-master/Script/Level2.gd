extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
#var first = true

var previousNum = -1
var startTimer = 50
var keyCamera = false

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	$ExitPortal.play()
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func _physics_process(delta):
	if $ExitPortal.playing == false:
		if keyCamera == false:
			keyCamera = true
			var key = load("res://Scenes/Key.tscn").instance()
			randomPlacement(key)
			key.createKey()
#	if startTimer > 0:
#		startTimer -= 1
#	else:
#		if keyCamera == false:
#			keyCamera = true
#			var key = load("res://Scenes/Key.tscn").instance()
#			randomPlacement(key)
#			key.createKey()
			
		

func randomPlacement(var obj):

	add_child(obj)
	var i = previousNum
	while i == previousNum:
		randomize()
		i = randi() % 9

	previousNum = i
#	print("I value: " + str(i))
#	i = 0
	if i == 0:
#		450, 1520
		obj.position.x = 450
		obj.position.y = 1520
	elif i == 1:
#		958, 1624
		obj.position.x = 958
		obj.position.y = 1642
	elif i == 2:
#		809, 1795
		obj.position.x = 809
		obj.position.y = 1795
	elif i == 3:
#		1047, 2002
		obj.position.x = 1047
		obj.position.y = 2002
	elif i == 4:
#		623, 2023
		obj.position.x = 623
		obj.position.y = 2023
	elif i == 5:
#		375, 2054
		obj.position.x = 375
		obj.position.y = 2054
	elif i == 6:
#		403, 1778
		obj.position.x = 403
		obj.position.y = 1778
	elif i == 7:
#		404, 1953
		obj.position.x = 404
		obj.position.y = 1953
	elif i == 8:
#		98, 2106
		obj.position.x = 98
		obj.position.y = 2106
	
#	print("X: " + str(obj.position.x))
#	print("Y: " + str(obj.position.y))

func createPortal():
	var worldPortal = load("res://Scenes/WorldComplete.tscn").instance()
	randomPlacement(worldPortal)
	worldPortal.nextScene = "res://Scenes/GameFinished.tscn"
	worldPortal.createPortal()
	
