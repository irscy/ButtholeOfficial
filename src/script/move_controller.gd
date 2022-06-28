extends Node2D

class_name move_controller

var defined_sprite : AnimatedSprite2D
var flip_anim : AnimationPlayer

var x_speed : Vector2 = Vector2(200, 0)
var y_speed : Vector2 = Vector2(0, 200)

var left : bool
var right : bool
var up : bool
var down : bool
var horiz : bool
var vertic : bool
var can_play_horiz_anim : bool
var can_play_vertic_anim : bool
var can_play_down_anim : bool

@export var horiz_spr : String
@export var up_spr : String
@export var down_spr : String
@export var idle_spr : String

func _ready() -> void:
	set_object_values()
	set_indexed("position:y", get_viewport_rect().size.y * 0.5 + 75)
	
func _physics_process(delta) -> void:
	enable_move_controls(delta)
	
# MOVEMENT
func enable_move_controls(delta : float) -> void:
	# if left key is held down
	if Input.is_action_pressed("Move Left") && !right && !vertic:
		global_position -= x_speed * delta
		scale = Vector2(1, 1)
		left = true
		horiz = true
		defined_sprite.animation = horiz_spr
		defined_sprite.playing = true
	
	# if left key is released
	if Input.is_action_just_released("Move Left"):
		left = false
		horiz = false
		defined_sprite.animation = idle_spr
		defined_sprite.playing = false
		
		
	# if right key is held down	
	if Input.is_action_pressed("Move Right") && !left && !vertic:
		global_position += x_speed * delta
		scale = Vector2(-1, 1)
		right = true
		horiz = true
		defined_sprite.animation = horiz_spr
		defined_sprite.playing = true
		
	# if right key is released
	if Input.is_action_just_released("Move Right"):
		right = false
		horiz = false
		defined_sprite.animation = idle_spr
		defined_sprite.playing = false


func set_object_values() -> void:
	defined_sprite = get_node("Sprite")
	flip_anim = get_node("Sprite/FlipAnim")
