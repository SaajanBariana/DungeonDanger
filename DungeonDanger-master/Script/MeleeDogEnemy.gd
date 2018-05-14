extends KinematicBody2D

const SPEED = 40
const up = Vector2(0, -0.5)
const down = Vector2(0, 0.5)
const left = Vector2(-0.5, 0)
const right = Vector2(0.5, 0)

var movetimer_length = 100
var wait_timer_length = 1000
var wait_timer = 0
var movetimer = 0
var move_dir
var blacklistDirection
var attackingWaitTime = 0
var attackingResetTime = 50
var attackDistance = 0.75
var direction
var dead = false
var deathAnimationTimer = 100

var startedOldTime = false
var oldX
var oldY
var secondOldX
var secondOldY
var setWaitTime = 10
var waitTime = 10

var triedHealth = false

var inWall = false
var d 

var health = 100

func _ready():
	$Sprite.play("Idle")
	move_dir = rand()
	
func _physics_process(delta):
	if dead:
		if triedHealth == false:
			triedHealth = true
			if randHealthSpawn() == 1:
				$HealthBar.hide()
				var health = load("res://Scenes/HealthPotion.tscn").instance()
				get_parent().add_child(health)
				print("Added Health")
				health.position.x = self.position.x
				health.position.y = self.position.y
		elif deathAnimationTimer > 50:
			move_and_collide(Vector2(-direction.x/3, -direction.y/3))
		deathAnimationTimer-=1
		if deathAnimationTimer <= 0:
			queue_free()
	else:
		var checked = false
		var bodies = $Range.get_overlapping_bodies()
	#	print("Got bodies: " + str(len(bodies)))
		var player = get_parent().get_node("Player")
		if player in bodies:
	#		print("body: " + str(body))
	#		if body.name == "Player":
			checked = true
			
		if checked == false:
			startedOldTime = false
			waitTime = setWaitTime
			randomMovement()
		else:
			if startedOldTime == false:
				startedOldTime = true
				oldX = position.x
				oldY = position.y
			
			if waitTime > 0:
				waitTime -= 1
			else:
				if oldX == position.x and oldY == position.y:
					if secondOldX == position.x and secondOldY == position.y:
						var vec = Vector2(direction.x*100, direction.y*100)
						position.x += vec.x
						position.y += vec.y
					else:	
						var vec = Vector2(direction.x*50, direction.y*50)
						position.x += vec.x
						position.y += vec.y
#					move_and_collide(Vector2(direction.x/3, direction.y/3))
				else:
					waitTime = setWaitTime
					secondOldX = oldX
					secondOldY = oldY
					oldX = position.x
					oldY = position.y
			direction = (player.get_global_position() - self.get_global_position()).normalized()
			if direction.x > 0:
				$Sprite.flip_h = true
			else:
				$Sprite.flip_h = false
				
			$Sprite.play("Walking")
			if player in $AttackDistance.get_overlapping_bodies():
				$Sprite.play("Attack")
				if attackingWaitTime <= 0:
					playAttack()
					player.changeHealth(-5)
					attackingWaitTime = attackingResetTime
				else:
					attackingWaitTime -= 1
	#		if (direction.x > -attackDistance and direction.y < attackDistance) and (direction.y > -attackDistance and direction.y < attackDistance):
				
	
	#		else:
#				attackingWaitTime = attackingResetTime



#			var count = 0
#			if player.readyToAttack == true:
#				if Input.is_action_pressed("ui_accept"):
#					var attackingRange = player.attackRange.get_overlapping_bodies()
#					for body in attackingRange:
#						if body == self:
#							body.changeHealth(-10)
#					player.readyToAttack = false
					
					
					
					
#			if self in player.attackRange.get_overlapping_bodies():
#				if Input.is_action_pressed("ui_accept"):
#					changeHealth(-10)
		
			var collisionObject = move_and_collide(Vector2(direction.x/2, direction.y/2))		
		
func playAttack():
	randomize()
	var i = randi() % 2
	if i == 0:
		$Attack1.play()
	else:
		$Attack2.play()

func movement_loop():
	var motion = move_dir.normalized() * SPEED
	return move_and_collide(move_dir)
	
func randWaitTime():
	var d = randi() % 300 + 700
	return d
	
func randHealthSpawn():
	return randi()%4
	
func randMoveTime():
	var d = randi() % 100 + 50
	return d
	
func rand():
	var d = randi() % 4 + 1
	match d:
		1: 
			$Sprite.flip_h = false
			return left
		2: 
			$Sprite.flip_h = true
			return right
		3: 
			return up
		4: 
			return down
			
func randomMovement():
	if movetimer > 0:
		movetimer -= 1
		movement_loop()
		$Sprite.play("Walking")
		if is_on_wall():
			movetimer = 0
			blacklistDirection = move_dir
#			print("on the wall")
	elif movetimer == 0:
		if wait_timer > 0:
			wait_timer -= 1
			if wait_timer <= 50 || wait_timer >= wait_timer_length - 50:
				$Sprite.play("Stop")
			else:
				$Sprite.play("Idle")
		else:
			wait_timer_length = randWaitTime()
			wait_timer = wait_timer_length
			move_dir = rand()
			blacklistDirection = ""
			movetimer_length = randMoveTime()
			movetimer = movetimer_length

func playHurt():
	randomize()
	var i = randi() % 2
	if i == 0:
		$Hurt1.play()
	else:
		$Hurt2.play()

func changeHealth(var change):
	health+=change
	$HealthBar.value = health
	
	if health <= 0:
		$Death.play()
		dead = true
		$Sprite.flip_v = true
		$Sprite.play("Stop")
		move_and_collide(Vector2(-direction.x/3, -direction.y/3))
		$CollisionShape2D.disabled = true
	else:
		playAttack()
		$CollisionShape2D.disabled = true
		moveBack(20)
		$CollisionShape2D.disabled = false
		
				
func moveBack(var num):
	if num <= 0:
		pass
	elif inWall == false:
		move_and_collide(Vector2(-direction.x, -direction.y))
#		var bodies = $AttackDistance.get_overlapping_areas()
#		for i in bodies:
#			if i == null:
#				print("Null")
#			else:
#				print(i.name)
		moveBack(num-1)

func pushBack():
	move_and_collide(Vector2(direction.x, direction.y))
			
#		print("Hit: " + str(hit))
#		while get_parent() in bodies: 
#			print("Stuck in wall")
#			hit = move_and_collide(Vector2(direction.x*5, direction.y*5))
		
#	print("Health: " + str(health))