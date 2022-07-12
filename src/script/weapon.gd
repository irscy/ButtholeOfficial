extends Area2D

class_name weapon

# variables
var sprite_child : Node2D
var weapon_holder : Node2D
var swing_anim : AnimationPlayer
var swing_timer : Timer
var anim_box_enable : Timer
var hitbox : CollisionShape2D
var swing_delay : float = 0.4
var swing_index : int
var can_swing : bool = true
var hitbox_enabled : bool = false

func _ready() -> void:
	set_variable_values()
	
func _physics_process(delta):
	run_swing(delta)
	
	print(swing_timer.time_left)
	
	if swing_anim.is_playing():
		hitbox.disabled = false
	else:
		hitbox.disabled = true
		
	if hitbox_enabled:
		hitbox.disabled = false
	else:
		hitbox.disabled = true
	
func on_swing_timeout_complete() -> void:
	can_swing = true
	
func on_hitbox_enable_complete() -> void:
	hitbox_enabled = false
	
func run_swing(delta : float) -> void:
	if Input.is_action_just_pressed("Swing Weapon") && can_swing && !hitbox_enabled && swing_index % 2 == 0:
		swing_anim.stop(true)
		swing_anim.play("SwingDown")
		swing_index += 1
		can_swing = false
		hitbox_enabled = true
		anim_box_enable.start()
		swing_timer.start()
	
	elif Input.is_action_just_pressed("Swing Weapon") && can_swing && !hitbox_enabled && swing_index % 2 != 0:
		swing_anim.stop(true)
		swing_anim.play("SwingUp")
		swing_index += 1
		can_swing = false
		hitbox_enabled = true
		anim_box_enable.start()
		swing_timer.start()
		
	if swing_index > 6:
		swing_index = 1
		
# setting variable values
func set_variable_values() -> void:
	# misc
	swing_anim = $SwingAnim
	swing_index = 1
	sprite_child = $Sprite
	weapon_holder = get_parent()
	hitbox = $Hitbox
	
	position = Vector2(-24, -50)
	rotation = deg2rad(-77)
	
	# timer shit
	swing_timer = Timer.new()
	swing_timer.one_shot = true
	swing_timer.wait_time = swing_delay
	swing_timer.timeout.connect(Callable(self, "on_swing_timeout_complete"))
	add_child(swing_timer)
	
	anim_box_enable = Timer.new()
	anim_box_enable.one_shot = true
	anim_box_enable.wait_time = swing_timer.wait_time
	anim_box_enable.timeout.connect(Callable(self, "on_hitbox_enable_complete"))
	add_child(anim_box_enable)
