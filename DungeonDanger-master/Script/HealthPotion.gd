extends Area2D

export (String, FILE, "*.tscn") var World_Scene

func _physics_process(delta):
	var bodies = get_overlapping_bodies()

	for body in bodies:
		if body.name == "Player":
			body.changeHealth(10)
			queue_free()
