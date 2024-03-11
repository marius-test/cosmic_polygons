extends Node3D

@onready  var main = get_tree().current_scene
var Enemy = load("res://enemy.tscn")

func spawn():
	var enemy = Enemy.instantiate()
	main.add_child(enemy)
	enemy.transform.origin = transform.origin + Vector3(randi_range(-15, 15), randi_range(-10, 10), 0)

func _on_timer_timeout():
	spawn()
