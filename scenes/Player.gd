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

@onready var animplayer = $AnimatedSprite2D

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
			animation = "jalan_kanan"
			velocity.x = direction * walk_speed
			
			if direction > 0:
				animplayer.flip_h = false
			else:
				animplayer.flip_h = true
		else:
			velocity.x = 0

	if animplayer.animation != animation:
		animplayer.play(animation)

	move_and_slide()

func start_dash(dir):
	is_dashing = true
	can_dash = false
	velocity.x = dir * dash_speed
	velocity.y = 0
	
	await get_tree().create_timer(dash_duration).timeout
	is_dashing = false
