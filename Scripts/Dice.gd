extends Area2D

signal game_over

# Change 'const' to 'var' so the Game script can modify it!
var fall_speed: float = 100.0 
const SPIN_SPEED: float = 300.0
var _spin_direction: float = 0.0

func _ready() -> void:
	_spin_direction = [ -1.0, 1.0 ].pick_random()
	rotation_degrees = randf_range(0, 360)

func _physics_process(delta: float) -> void:
	# Use the variable name here
	position.y += fall_speed * delta 
	rotation_degrees += (SPIN_SPEED * _spin_direction) * delta
	check_game_over()

func check_game_over() -> void:
	if get_viewport_rect().end.y < position.y:
		game_over.emit()
		queue_free()
