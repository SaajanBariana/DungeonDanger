extends Sprite

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _physics_process(delta):
	var enemy = get_children()
	print("\n\n\n\n\nSTART")
	for i in enemy:
		print(i.name)
	var bodies = $WallCollision.get_overlapping_bodies()
	for i in bodies:
		if i.name.find("Enemy") >= 0:
			print("Enemy in wall")
			i.inWall = true
			i.pushBack()
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func checkWalls():
	var bodies = $Wall2/WallCollision.get_overlapping_bodies()
	for i in bodies:
		if i.name.find("Enemy") >= 0:
			print("Enemy in wall")
			i.inWall = true
			i.pushBack()
			
	var bodies1 = $Wall1/WallCollision.get_overlapping_bodies()
	for i in bodies1:
		if i.name.find("Enemy") >= 0:
			print("Enemy in wall")
			i.inWall = true
			i.pushBack()