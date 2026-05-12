extends Node2D

const DICE_SCENE = preload("res://Scenes/Dice.tscn")
const MAX_DIFFICULTY_TIME: float = 150.0 

var elapsed_time: float = 0.0
var miss_count: int = 0

#Variables
@onready var wave_timer: Timer = $WaveTimer
@onready var screen_width: float = get_viewport_rect().size.x
@onready var bgm: AudioStreamPlayer2D = $BGM
@onready var game_over_sound: AudioStreamPlayer2D = $GameOverSound
@onready var score: Label = $Score 

func _ready() -> void:
	# Set the game script to Always run so ESC works during pause
	process_mode = Node.PROCESS_MODE_ALWAYS

# Using _unhandled_input is the "cleanest" way to catch key presses
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("restart"):
		# Unpause first, then reload
		get_tree().paused = false
		get_tree().reload_current_scene()

func _process(delta: float) -> void:
	if not get_tree().paused:
		elapsed_time += delta
		# Update the UI Label with the Fox's score
		if $Fox:
			$Score.text = "Score: %04d" % $Fox.score

func _on_wave_timer_timeout() -> void:
	var difficulty = clamp(elapsed_time / MAX_DIFFICULTY_TIME, 0.0, 1.0)
	spawn_wave(difficulty)
	update_difficulty_and_timer(difficulty)

func spawn_wave(difficulty: float) -> void:
	var dice_count: int = randi_range(1 + int(difficulty * 2), 3 + int(difficulty * 3))
	var spawn_positions = get_spaced_spawn_positions(dice_count)
	
	for i in range(dice_count):
		var new_dice = DICE_SCENE.instantiate()
		var vertical_gap: float = 150.0 
		var staggered_y: float = -50.0 - (i * vertical_gap)
		
		new_dice.position = Vector2(spawn_positions[i], staggered_y)
		new_dice.fall_speed = lerp(100.0, 700.0, difficulty)
		
		# Set the dice to a group so they can be identified
		new_dice.add_to_group("dice")
		new_dice.game_over.connect(_on_dice_game_over, CONNECT_ONE_SHOT)
		
		add_child(new_dice)

func get_spaced_spawn_positions(count: int) -> Array[float]:
	var margin = 100.0 
	var safe_zone = screen_width - (margin * 2)
	var positions: Array[float] = []
	var lane_width = safe_zone / count
	
	for i in range(count):
		var lane_start = margin + (i * lane_width)
		var lane_end = lane_start + lane_width
		positions.append(randf_range(lane_start, lane_end))
		
	positions.shuffle()
	return positions

func update_difficulty_and_timer(difficulty: float) -> void:
	var base_wait = lerp(5.0, 0.8, difficulty)
	if wave_timer:
		wave_timer.wait_time = max(base_wait + randf_range(-0.5, 0.5), 0.4)
		wave_timer.start()

func _on_dice_game_over() -> void:
	if get_tree().paused:
		return
	miss_count += 1
	print("Lives lost: %d/3" % miss_count)
   
	if miss_count >= 3:
		# Stop the music and play the crash/munch sound
		if bgm: 
			bgm.stop()
		if game_over_sound:
			game_over_sound.play()

			get_tree().paused = true
			print("GAME OVER! Press ESC to Restart.")
