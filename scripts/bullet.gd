extends CharacterBody3D

func _physics_process(_delta):
	# moves the bullet using slide collision
	move_and_slide()

func _on_area_3d_body_entered(body):
	# handle collision with other bodies
	if body.is_in_group("Enemies"):
		body.enemy_explode()  # trigger enemy explosion
