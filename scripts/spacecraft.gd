extends CharacterBody3D

# constants for player movement
const MAXSPEED = 30
const ACCELEARTION = 0.75

# input vector for movement
var inputVector = Vector3()

# cooldown timer for shoting
var cooldown = 0
const COOLDOWN = 8


var Bullet = load("res://scenes/bullet.tscn")  # load the bullet scene
@onready var gun_sound = %GunSound  # sound effect for shooting
@onready var guns = [$Gun0, $Gun1]  # list of gund nodes
@onready var main = get_tree().current_scene  # reference to the main scene

func _physics_process(_delta):
	move_and_slide()  # moves the player using slide collision
	
	# apply acceleration to the player velocity
	velocity.x = move_toward(velocity.x, inputVector.x * MAXSPEED, ACCELEARTION)
	velocity.y = move_toward(velocity.y, inputVector.y * MAXSPEED, ACCELEARTION)

func _process(delta):
	# handle player controls
	inputVector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	inputVector.y = Input.get_action_strength("move_up") - Input.get_action_strength("move_down")
	inputVector = inputVector.normalized()
	
	# rotate the player based on velocity
	rotation_degrees.z = velocity.x * -2
	rotation_degrees.x = velocity.y / 2
	rotation_degrees.y = -velocity.x / 2
	
	# clamp player position within bounds
	transform.origin.x = clamp(transform.origin.x, -15, 15)
	transform.origin.y = clamp(transform.origin.y, -10, 10)

	# shooting logic
	if Input.is_action_pressed("shoot") and cooldown <= 0:
		cooldown = COOLDOWN * delta
		for gun in guns:
			var bullet = Bullet.instantiate()
			main.add_child(bullet)
			bullet.global_transform.origin = gun.global_transform.origin
			bullet.velocity = bullet.transform.basis.z * -300
			gun_sound.play()

	#cooldown management
	if cooldown > 0:
		cooldown -= delta
