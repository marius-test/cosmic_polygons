extends CharacterBody3D

func _physics_process(_delta):
	move_and_slide()

func _on_area_3d_body_entered(body):
	if body.is_in_group("Enemies"):
		print("Bullet hit an enemy!")
		body.queue_free()
		queue_free()
