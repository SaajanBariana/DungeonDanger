
extends KinematicBody2D

#the current position of the player
var motion = Vector2(0, 0)

#the acceleration of the player
const ACCELERATION = 20

#the max speed the player will travel in any direction
const MAX_SPEED = 60

#the amount of friction for the player when they stop
const FRICTION = 7

var moved = false

var moveSpriteAmount = 3

#The process that loops through each frame
func _physics_process(delta):
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

	#adds the updated motion to the player
	move_and_slide(motion)

#moving to the right at a decreased speed
func movingRight():
	motion.x = min(motion.x + (ACCELERATION - 15), MAX_SPEED)
	#flips the sprite for walking sideways back to its original direction if it was changed and plays it
	if moved == true:
		$Sprite.translate(Vector2(moveSpriteAmount, 0))
		moved = false
	$Sprite.flip_h = true
	$Sprite.play("WalkingSideways")

#moving to the left at a decreased speed
func movingLeft():
	motion.x = max(motion.x - (ACCELERATION + 15), -MAX_SPEED)
	#flips the sprite for walking sideways horizontally and plays it
	if moved == true:
		$Sprite.translate(Vector2(moveSpriteAmount, 0))
		moved = false
	$Sprite.flip_h = false
	$Sprite.play("WalkingSideways")

#moving up at a decreased speed
func movingUp():
	motion.y = max(motion.y - (ACCELERATION - 15), -(4 * (MAX_SPEED/5)))

#moving down at a decreased speed
func movingDown():
	motion.y = min(motion.y + (ACCELERATION -15), (4 * (MAX_SPEED/5)) )
