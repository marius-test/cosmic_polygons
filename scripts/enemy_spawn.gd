extends Node3D

@onready  var main = get_tree().current_scene  # reference to the main scene
var Enemy = load("res://scenes/enemy.tscn")  # load the enemy scene

# spawn new enemy
func spawn():
	var enemy = Enemy.instantiate()
	main.add_child(enemy)
	enemy.transform.origin = transform.origin + Vector3(randi_range(-15, 15), randi_range(-10, 10), 0)
	# set the enemy position with some random offset

# called when the timer times out
func _on_timer_timeout():
	spawn()
