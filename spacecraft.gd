extends CharacterBody3D

const MAXSPEED = 30
const ACCELEARTION = 0.75
var inputVector = Vector3()
var cooldown = 0
const COOLDOWN = 8

@onready var guns = [$Gun0, $Gun1]
@onready var main = get_tree().current_scene
var Bullet = load("res://bullet.tscn")

func _physics_process(_delta):
	move_and_slide()
	velocity.x = move_toward(velocity.x, inputVector.x * MAXSPEED, ACCELEARTION)
	velocity.y = move_toward(velocity.y, inputVector.y * MAXSPEED, ACCELEARTION)

func _process(delta):
	inputVector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	inputVector.y = Input.get_action_strength("move_up") - Input.get_action_strength("move_down")
	inputVector = inputVector.normalized()
	rotation_degrees.z = velocity.x * -2
	rotation_degrees.x = velocity.y / 2
	rotation_degrees.y = -velocity.x / 2
	transform.origin.x = clamp(transform.origin.x, -15, 15)
	transform.origin.y = clamp(transform.origin.y, -10, 10)

	# shooting
	if Input.is_action_pressed("shoot") and cooldown <= 0:
		cooldown = COOLDOWN * delta
		for gun in guns:
			var bullet = Bullet.instantiate()
			main.add_child(bullet)
			bullet.global_transform.origin = gun.global_transform.origin
			bullet.velocity = bullet.transform.basis.z * -300
			
	#cooldown
	if cooldown > 0:
		cooldown -= delta
		
