extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var creating = false
var player
var changeTimer = 200

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	player = get_parent().get_node("Wall").get_node("Player")
	player.visible = false
	
	
func _physics_process(delta):
	if creating == true:
		if changeTimer > 0:
			changeTimer -= 1
		else:
			player.visible = true
			print("Ended Sprite")
			creating = false
			player.setCamera()
			$Sprite.play("Idle")
#			$Camera2D.clear_current()
			
	else:
		if player in get_overlapping_bodies():
			player.setFoundKey(true)
			queue_free()
			get_parent().createPortal()


func createKey():
	$Sprite.play("Creating")
	creating = true
	$Camera2D.make_current()


#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
