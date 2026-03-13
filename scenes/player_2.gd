extends CharacterBody2D

@export var gravity = 500.0
@export var walk_speed = 200
@export var jump_speed = -300

var jump_count = 0
var max_jumps = 2

@export var dash_speed = 600
@export var dash_duration = 0.15
var is_dashing = false
var can_dash = true

var last_tap_time_left = 0.0
var last_tap_time_right = 0.0
const DOUBLE_TAP_DELAY = 0.25 

@export var fall_limit_y: float = 600.0 
@export var fade_distance: float = 400.0
@onready var bgm_sound = $"../AudioStreamPlayer2D" 

@onready var animplayer = $AnimatedSprite2D
@onready var footstep_sound = $AudioStreamPlayer2D

func _physics_process(delta):
	if not is_on_floor() and not is_dashing:
		velocity.y += delta * gravity
	
	if is_on_floor():
		jump_count = 0
		can_dash = true

	if can_dash:
		if Input.is_action_just_pressed("ui_left"):
			var current_time = Time.get_ticks_msec() / 1000.0
			if current_time - last_tap_time_left < DOUBLE_TAP_DELAY:
				start_dash(-1)
			last_tap_time_left = current_time
			
		if Input.is_action_just_pressed("ui_right"):
			var current_time = Time.get_ticks_msec() / 1000.0
			if current_time - last_tap_time_right < DOUBLE_TAP_DELAY:
				start_dash(1)
			last_tap_time_right = current_time

	if Input.is_action_just_pressed('ui_up') and not is_dashing:
		if is_on_floor() or jump_count < max_jumps:
			velocity.y = jump_speed
			jump_count += 1

	var animation = "idle"

	if not is_dashing:
		var direction := Input.get_axis("ui_left", "ui_right")
		
		if direction:
			animation = "walk"
			velocity.x = direction * walk_speed
			
			if direction > 0:
				animplayer.flip_h = false
			else:
				animplayer.flip_h = true
		else:
			velocity.x = 0

	if animplayer.animation != animation:
		animplayer.play(animation)

	if global_position.y > fall_limit_y:
		var distance_fallen = global_position.y - fall_limit_y
		var fade_ratio = clamp(distance_fallen / fade_distance, 0.0, 1.0)
		
		if bgm_sound:
			bgm_sound.volume_db = lerp(0.0, -80.0, fade_ratio)
	else:
		if bgm_sound:
			bgm_sound.volume_db = 0.0

	move_and_slide()

func start_dash(dir):
	is_dashing = true
	can_dash = false
	velocity.x = dir * dash_speed
	velocity.y = 0
	
	await get_tree().create_timer(dash_duration).timeout
	is_dashing = false

func _on_animated_sprite_2d_frame_changed():
	if animplayer.animation == "walk" and is_on_floor():
		if animplayer.frame == 1 or animplayer.frame == 3: 
			footstep_sound.pitch_scale = randf_range(0.8, 1.2) 
			footstep_sound.play()
