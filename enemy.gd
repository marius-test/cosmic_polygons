extends CharacterBody3D

var enemy_speed = randi_range(20, 50)

func _physics_process(_delta):
	velocity.z = enemy_speed
	move_and_slide()
	if transform.origin.z > 10:
		queue_free()
