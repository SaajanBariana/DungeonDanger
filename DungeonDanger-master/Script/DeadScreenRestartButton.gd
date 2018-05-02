extends TextureButton

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _toggled(button_pressed):
	if button_pressed == true:
		get_tree().change_scene("res://Scenes/Level1.tscn")

		

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
