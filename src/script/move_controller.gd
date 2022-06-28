extends Node2D

class_name move_controller

var definedSprite : AnimatedSprite2D = $Sprite
var flipAnim : AnimationPlayer = $Sprite/FlipAnim

var xSpeed : Vector2 = Vector2(200, 0)
var ySpeed : Vector2 = Vector2(0, 200)

var left : bool
var right : bool
var up : bool
var down : bool
var horiz : bool
var vertic : bool
var canPlayHorizAnim : bool
var canPlayVerticAnim : bool
var canPlayDownAnim : bool

@export var horizSpr : String
@export var upSpr : String
@export var downSpr : String
@export var idleSpr : String

func _ready() -> void:
	set_indexed("position:y", get_viewport_rect().size.y * 0.5 + 75)
	
func _physics_process(delta) -> void:
	enable_move_controls(delta)
	
# MOVEMENT
func enable_move_controls(delta : float) -> void:
	# if left key is held down
	if Input.is_action_pressed("Move Left") && !right && !vertic:
		global_position -= xSpeed * delta
		scale = Vector2(1, 1)
		left = true
		horiz = true
		definedSprite.animation = horizSpr
		definedSprite.playing = false
	
	if Input.is_action_just_released("Move left"):
		left = false
		
