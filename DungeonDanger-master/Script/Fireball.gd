extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var direction
var player
var hitObject = false

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass
	
#	player = get_parent().get_parent().get_node("Player")
#	direction = (player.get_global_position() - self.get_global_position()).normalized()
#	if direction.x > 0:
#		$Sprite.flip_h = true
#	else:
#		$Sprite.flip_h = false

func _physics_process(delta):
	if hitObject == true:
		if $FireballExplode.playing == false:
			queue_free()
	elif direction != null:
		var collidedWith = move_and_collide(Vector2(direction.x, direction.y))
		var bodies = $CollisionRange.get_overlapping_bodies()
#		print(str(bodies))
		for i in bodies:
#			print(str(i.name))
			if i.name.find("Ranged") >= 0:
				get_parent().changeYPosition(50)

				pass
#				$CollisionShape2D.disabled = true
#				$CollisionRange/FireballCollisionShape.disabled = true
			
			if i.name == "Player":
#				if $CollisionShape2D.disabled == true:
				player.changeHealth(-5)
				$FireballExplode.play()
				hitObject = true
				visible = false
				$CollisionShape2D.disabled = true
			elif i.name == "Wall" or i.name.find("Melee") >= 0 or (i.name == "Fireball" and i != self) or i.name.find("Ranged") >= 0:
				$FireballExplode.play()
				hitObject = true
				visible = false
				$CollisionShape2D.disabled = true
#			elif $CollisionShape2D.disabled == true:
#				$CollisionShape2D.disabled = false
#				$CollisionRange/FireballCollisionShape.disabled = false
		
			
func setCoord(var player):
#	player = get_parent().get_parent().get_node("Player")
	self.player = player
	direction = (player.get_global_position() - self.get_global_position()).normalized()
	if direction.x > 0:
		$Sprite.flip_h = true
	else:
		$Sprite.flip_h = false
	




#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
