extends Area2D

class_name Fox

@export var speed: float = 500.0 # Increased speed for better feel

@onready var fox: AnimatedSprite2D = $AnimatedSprite2D
@onready var sounds: AudioStreamPlayer2D = $Sounds

var score: int = 0

func _physics_process(delta: float) -> void:
	# Professional way to handle horizontal movement
	var direction = Input.get_axis("ui_left", "ui_right")
	
	# Check if sprite exists before using it to prevent the 'null instance' error
	if fox:
		if direction < 0:
			fox.flip_h = true  # Facing Right
		elif direction > 0:
			fox.flip_h = false # Facing Left
	
	position.x += direction * speed * delta
	
	# Keep the fox on screen
	var screen_width = get_viewport_rect().size.x
	position.x = clamp(position.x, 50, screen_width - 50)

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("dice"):
		score += 1 # Increment the score 
		if sounds:
			sounds.play() # Play munching sound 
		
		# We NO LONGER reset miss_count here so misses act as lives [cite: 9]
		area.queue_free() # Remove the dice
