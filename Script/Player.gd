
extends KinematicBody2D

#the current position of the player
var motion = Vector2(0, 0)

#the acceleration of the player
const ACCELERATION = 20

#the max speed the player will travel in any direction
var MAX_SPEED = 60

#the amount of friction for the player when they stop
var FRICTION = 7

var moved = false

var moveSpriteAmount = 3

var health = 100

var attackReset = 20

var attackCooldown = 0

var direction = "left"

var moveAttackAreaAmount = 20

var attackRange

var readyToAttack

var bodiesToAttack

var heathAnimationTimer = 100

var dead = false

var paused = false

var foundKey = false

func _ready():
	attackRange = $AttackRange
	readyToAttack = true
#	$WalkingSound.set("params/pitch_scale", -10)
	$StartingPhrase.play()



#The process that loops through each frame
func _physics_process(delta):
	if attackCooldown > 0:
		attackCooldown-=1
	
	if attackCooldown <= 0:
		readyToAttack = true
	
	if health <= 0:
		if dead == false:
			dead = true
			$Sprite.play("Idle")
			$Sprite.rotate(90)
			$CollisionShape2D.disabled = true
		if dead == true:
			heathAnimationTimer -= 1
			if heathAnimationTimer <= 0:
				get_tree().change_scene("res://Scenes/DeathScreen.tscn")
#				$BackgroundMusic.stop()
	else:
		if Input.is_action_pressed("ui_cancel"):
			if paused == false:
				paused = true
				get_tree().paused = true
				_draw()
			else:
				paused = false
				get_tree().paused = false
		
#		var collisionWithBody = $AttackRange.get_overlapping_bodies()
		
		
		
		var foundFriction = false
		
	#	for something in collisionWithBody:
	#		if something.name.find("Mud") >= 0:
	#			FRICTION = 10
	#			MAX_SPEED = 30
	#			foundFriction = true
	#
	#	if foundFriction == false:
	#		if FRICTION != 7:
	#			FRICTION = 7
	#			MAX_SPEED = 60
		
			
		var bodies = $AttackRange.get_overlapping_bodies()
		
		for body in bodies:
			if body.name.find("Mud") >= 0:
				FRICTION = 10
				MAX_SPEED = 30
				print("In Mud")
				foundFriction = true
			
				
		if foundFriction == false:
			if FRICTION != 7:
				FRICTION = 7
				MAX_SPEED = 60
	
		if Input.is_action_pressed("ui_accept"):
			if readyToAttack:
				attackCooldown = attackReset
				motion.x = 0
				motion.y = 0
				move_and_slide(motion)
				$Sprite.play("Attack")
				$PlayerAttackingSound.play()
				
	#			var bodies = $AttackRange.get_overlapping_bodies()
	#			var enemy = get_parent().get_node("MeleeDogEnemy")
				for body in bodies:
	#				print("Name: " + body.name)
					if body.name.find("Enemy") >= 0:
						body.changeHealth(-20)
					
					
				readyToAttack = false
				
		else:
			#checks if the right arrow is being pressed
			if Input.is_action_pressed("ui_right"):
				#checks if the down arrow is being pressed
				if Input.is_action_pressed("ui_down"):
					#moves down and to the right at a slightly decreased speed
					movingDown()
					movingRight()
		
				#checks if the up arrow is being pressed
				elif Input.is_action_pressed("ui_up"):
					#moves up and to the right at a slightly decreased speed
					movingUp()
					movingRight()
		
				#moves to the right at a normal speed
				else:
					if $WalkingSound.playing == false:
	#					$WalkingSound.set("params/pitch_scale", -10)
						$WalkingSound.play()
					if direction != "right":
						direction = "right"
						$AttackRange.translate(Vector2(moveAttackAreaAmount, 0))
					motion.x = min(motion.x + ACCELERATION, MAX_SPEED)
					#flips the sprite for walking sideways back to its original direction if it was changed and plays it
					if moved == true:
						$Sprite.translate(Vector2(moveSpriteAmount, 0))
						moved = false
					$Sprite.flip_h = true
					$Sprite.play("WalkingSideways")
		
				#stops moving up or down if your release those arrows
				if Input.is_action_just_released("ui_up") or Input.is_action_just_released("ui_down"):
					motion.y = 0
		
				
		
			#checks if the left arrow is being pressed
			elif Input.is_action_pressed("ui_left"):
				#checks if the down arrow is being pressed
				if Input.is_action_pressed("ui_down"):
					#moves down and to the left at a slightly decreased speed
					movingDown()
					movingLeft()
		
				#checks if the up arrow is being pressed
				elif Input.is_action_pressed("ui_up"):
					#moves up and to the left at a slightly decreased speed
					movingUp()
					movingLeft()
		
				#moves to the left at a normal speed
				else:
					if $WalkingSound.playing == false:
						$WalkingSound.play()
					if direction != "left":
						direction = "left"
						$AttackRange.translate(Vector2(-moveAttackAreaAmount, 0))
					motion.x = max(motion.x - ACCELERATION, -MAX_SPEED)
					#flips the sprite for walking sideways horizontally and plays it
					if moved == true:
						$Sprite.translate(Vector2(moveSpriteAmount, 0))
						moved = false
					$Sprite.flip_h = false
					$Sprite.play("WalkingSideways")
		
				#stops moving up or down if your release those arrows
				if Input.is_action_just_released("ui_up") or Input.is_action_just_released("ui_down"):
					motion.y = 0
		
			#checks if the up arrow is being pressed
			elif Input.is_action_pressed("ui_up"):
				#checks if the right arrow is pressed
				if Input.is_action_pressed("ui_right"):
					#moves to the right and up at a decreased speed and plays that sprite
					movingRight()
					movingUp()
		
				#checks if the left arrow is being pressed
				elif Input.is_action_pressed("ui_left"):
					#moves to the left and up at a decreased speed and plays that sprite
					movingLeft()
					movingUp()
		
				#moves up at a normal speed
				else:
					if $WalkingSound.playing == false:
						$WalkingSound.play()
					motion.y = max(motion.y - ACCELERATION, -MAX_SPEED)
					#plays the sprite of walking up
					if moved == false:
						$Sprite.translate(Vector2(-moveSpriteAmount, 0))
						moved = true
					$Sprite.flip_h = false
					$Sprite.play("WalkingUp")
		
				#if the right or left arrow is released, it stops moving in that direction
				if Input.is_action_just_released("ui_right") or Input.is_action_just_released("ui_left"):
					motion.x = 0
		
			#checks if the down arrow is being pressed
			elif Input.is_action_pressed("ui_down"):
				#checks if the right arrow is pressed
				if Input.is_action_pressed("ui_right"):
					#moves to the right and down at a decreased speed and plays that sprite
					movingRight()
					movingDown()
		
				#checks if the left arrow is being pressed
				elif Input.is_action_pressed("ui_left"):
					#moves to the left and down at a decreased speed and plays that sprite
					movingLeft()
					movingDown()
		
				#moves down at a normal speed
				else:
					if $WalkingSound.playing == false:
						$WalkingSound.play()
					motion.y = min(motion.y + ACCELERATION, MAX_SPEED)
					if moved == true:
						$Sprite.translate(Vector2(moveSpriteAmount, 0))
						moved = false
					#plays the sprite for walking down
		#			$Sprite.flip_h = false
					$Sprite.play("WalkingDown")
		
				#if the right or left arrow is released, it stops moving in that direction
				if Input.is_action_just_released("ui_right") or Input.is_action_just_released("ui_left"):
					motion.x = 0
		
			#if no arrow is being pressed
			else:
				if moved == true:
					$Sprite.translate(Vector2(moveSpriteAmount, 0))
					moved = false
				#plays the sprite for being idle
				$Sprite.play("Idle")
		
				#adds friction to the player so they go from moving to stopping
				if motion.x > 0:
					motion.x = max(motion.x- FRICTION, 0)
				elif motion.x < 0:
					motion.x = min(motion.x + FRICTION, 0)
				if motion.y > 0:
					motion.y = max(motion.y - FRICTION, 0)
				elif motion.y < 0:
					motion.y = min(motion.y + FRICTION, 0)
		
			if motion.x == 0 and motion.y == 0:
				$WalkingSound.stop()
			#adds the updated motion to the player
			move_and_slide(motion)
		
#moving to the right at a decreased speed
func movingRight():
	motion.x = min(motion.x + (ACCELERATION - 15), MAX_SPEED)
	#flips the sprite for walking sideways back to its original direction if it was changed and plays it
	if moved == true:
		$Sprite.translate(Vector2(moveSpriteAmount, 0))
		moved = false
	if direction != "right":
		direction = "right"
		$AttackRange.translate(Vector2(moveAttackAreaAmount, 0))
	$Sprite.flip_h = true
	$Sprite.play("WalkingSideways")
	if $WalkingSound.playing == false:
		$WalkingSound.play()

#moving to the left at a decreased speed
func movingLeft():
	motion.x = max(motion.x - (ACCELERATION + 15), -MAX_SPEED)
	#flips the sprite for walking sideways horizontally and plays it
	if moved == true:
		$Sprite.translate(Vector2(moveSpriteAmount, 0))
		moved = false
	if direction != "left":
		direction = "left"
		
		$AttackRange.translate(Vector2(-moveAttackAreaAmount, 0))
	$Sprite.flip_h = false
	$Sprite.play("WalkingSideways")
	if $WalkingSound.playing == false:
		$WalkingSound.play()

#moving up at a decreased speed
func movingUp():
	motion.y = max(motion.y - (ACCELERATION - 15), -(4 * (MAX_SPEED/5)))
	if $WalkingSound.playing == false:
		$WalkingSound.play()

#moving down at a decreased speed
func movingDown():
	if $WalkingSound.playing == false:
		$WalkingSound.play()
	motion.y = min(motion.y + (ACCELERATION -15), (4 * (MAX_SPEED/5)) )

func changeHealth(var change):
	
	if health > 0:
		health = min(health + change, 100)
		
	if health < 0:
		health = max(health + change, 0)
	
	$ProgressBar.value = health
	if change < 0:
		if $PlayerHurt.playing == false:
			$PlayerHurt.play()

func setFoundKey(var value):
	foundKey = value
	
func setCamera():
	$Camera2D.make_current()


func _draw():
    var pos = get_viewport().get_visible_rect().size/2 #get center of the screen
    var rect_size = Vector2(150,200) #the size of your rectangle

    #because the rectangle origin is his top-left
    #does some correction to make it centered
    var rect_pos = pos - rect_size/2 

    #create your Rect2
    var rect = Rect2(rect_pos, rect_size )

    #drawn Rect
    draw_rect( rect, Color(0,0,0) )

    #drawn circle (origin is center by default)
    draw_circle( pos, 10, Color(1,.2,.5) )