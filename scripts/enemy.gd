extends CharacterBody3D

@onready var collision_shape_3d = %CollisionShape3D
@onready var enemy_mesh = %EnemyMesh
@onready var explosion_sound = %ExplosionSound
@onready var enemy_explosion = %EnemyExplosion
var enemy_speed = randi_range(20, 50)
var has_been_hit = false  # flag to track whether the enemy was hit

func _physics_process(_delta):
	# moves the enemy using slide collision
	move_and_slide()

func _process(_delta):
	# set the enemy velocity
	velocity.z = enemy_speed
	if transform.origin.z > 30:
		queue_free()  # removes the enemy from the scene when it is out of bounds

func disable_enemy_mesh():
	# disables enemy mesh
	enemy_mesh.visible = false

func enemy_explode():
	# trigger the exploision effect and sound
	if not has_been_hit:  # run the explosion only once
		explosion_sound.play()
		enemy_explosion.restart()
		has_been_hit = true
		disable_enemy_mesh()
		await get_tree().create_timer(1.75).timeout
		queue_free()  # removes the enemy from the scene

func enable_collision():
	if collision_shape_3d:
		collision_shape_3d.set_disabled(false)
