extends Area2D

var nextScene
var creating = false
var player
var changeTimer = 200

func _ready():
	player = get_parent().get_node("Wall").get_node("Player")

func _physics_process(delta):
	if creating == true:
		if changeTimer > 0:
			changeTimer -= 1
		else:
			print("Ended Sprite")
			creating = false
			player.setCamera()
			$Sprite.play("Idle")
#			$Camera2D.clear_current()
			
	else:
		
		var bodies = get_overlapping_bodies()
		for body in bodies:
			if body.name == "Player":
				get_tree().change_scene(nextScene)

func createPortal():
	$Sprite.play("Creating")
	creating = true
	$Camera2D.make_current()
