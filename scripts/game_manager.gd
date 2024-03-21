extends Node

@onready var game_over_text = %GameOverText
@onready var spacecraft = %Spacecraft

func _ready():
	if spacecraft:
		spacecraft.connect("game_over", on_game_over)

func on_game_over():
		game_over_text.visible = true
