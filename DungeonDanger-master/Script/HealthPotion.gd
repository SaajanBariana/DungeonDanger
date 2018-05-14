extends Area2D

export (String, FILE, "*.tscn") var World_Scene

var drinking = false

func _physics_process(delta):
	if drinking == true:
		if $Drink.playing == false:
			queue_free()
	
	var bodies = get_overlapping_bodies()
	
	for body in bodies:
		if body.name == "Player":
			$Drink.play()
			drinking = true
			body.changeHealth(20)
			visible = false
			$CollisionShape2D.disabled = true

