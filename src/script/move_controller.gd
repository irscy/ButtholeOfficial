extends Node2D

class_name move_controller

var defined_sprite : AnimatedSprite2D

var flip_anim : AnimationPlayer

var x_speed : Vector2 = Vector2(200, 0)
var y_speed : Vector2 = Vector2(0, 200)

var moving : bool
var left : bool
var right : bool
var up : bool
var down : bool
var horiz : bool
var vertic : bool
var can_play_horiz_anim : bool
var can_play_up_anim : bool
var can_play_down_anim : bool

@export var horiz_spr : String
@export var up_spr : String
@export var down_spr : String
@export var idle_spr : String

func _ready() -> void:
	set_variable_values()
	fix_transform()
	set_indexed("position:y", get_viewport_rect().size.y * 0.5 + 75)
	set_indexed("position:x", get_viewport_rect().size.x * 0.5)
	
func _physics_process(delta) -> void:
	enable_move_controls(delta)
	
func set_variable_values() -> void:
	defined_sprite = get_node("Sprite")
	flip_anim = get_node("Sprite/FlipAnim")
	can_play_horiz_anim = true
	can_play_up_anim = true
	can_play_down_anim = true
	
func fix_transform() -> void:
	defined_sprite.scale = Vector2(0.6, 0.35)
	
# move controls (obviously)
func enable_move_controls(delta : float) -> void:
	# moving #
	# if left key is held down (make sure moving vertically and right is false)
	if Input.is_action_pressed("Move Left") && !right && !vertic:
		global_position -= x_speed * delta
		left = true
		horiz = true
		moving = true
		scale = Vector2(1, 1)
		if can_play_horiz_anim:
			flip_anim.stop(true)
			flip_anim.play("Horiz")
		can_play_horiz_anim = false
		defined_sprite.animation = horiz_spr
		defined_sprite.playing = true
	
	# if left key is released
	if Input.is_action_just_released("Move Left"):
		can_play_horiz_anim = true
		moving = false	
		left = false
		horiz = false
		if !moving:
			defined_sprite.animation = idle_spr
			defined_sprite.playing = false
		
		
	# if right key is held down (make sure moving vertically and left is false)
	elif Input.is_action_pressed("Move Right") && !left && !vertic:	
		global_position += x_speed * delta
		moving = true
		right = true
		horiz = true
		scale = Vector2(-1, 1)	
		if can_play_horiz_anim:
			flip_anim.stop(true)
			flip_anim.play("Horiz")
		can_play_horiz_anim = false
		defined_sprite.animation = horiz_spr
		defined_sprite.playing = true
		
	# if right key is released
	if Input.is_action_just_released("Move Right"):
		can_play_horiz_anim = true
		moving = false
		right = false
		horiz = false
		if !moving:
			defined_sprite.animation = idle_spr
			defined_sprite.playing = false
		
	
	# if up key is held down (make sure moving down is false)
	elif Input.is_action_pressed("Move Up") && !down && !horiz:
		global_position -= y_speed * delta
		moving = true
		up = true
		vertic = true
		if can_play_up_anim:
			flip_anim.stop(true)
			flip_anim.play("Up")
		can_play_up_anim = false
		defined_sprite.animation = up_spr
		defined_sprite.playing = true
		
	# if up key is released
	if Input.is_action_just_released("Move Up"):
		can_play_up_anim = true
		moving = false
		up = false
		vertic = false
		if !moving:
			defined_sprite.animation = idle_spr
			defined_sprite.playing = false
		
		
		# if down key is held down (make sure moving up is false)
	elif Input.is_action_pressed("Move Down") && !up && !horiz:
		global_position += y_speed * delta
		moving = true
		down = true
		vertic = true
		if can_play_down_anim:
			flip_anim.stop(true)
			flip_anim.play("Down")
		can_play_down_anim = false
		defined_sprite.animation = down_spr
		defined_sprite.playing =  true
		
	if Input.is_action_just_released("Move Down"):
		can_play_down_anim = true
		moving = false
		down = false
		vertic = false
		if !moving:
			defined_sprite.animation = idle_spr
			defined_sprite.playing = false
