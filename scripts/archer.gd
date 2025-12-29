extends CharacterBody2D

@onready var _sprite = $Sprite2D
@onready var _Hitbox = $Hitbox
@onready var _animation = $AnimationPlayer
const ArrowScene = preload("res://scenes/Arrow.tscn")


const SPEED = 300.0
const dashSPEEDy = 900.0
const dashSPEEDx = 1300.0
const JUMP_VELOCITY = -900.0

var canDash = false
var dashCooldown = 0.5
var lastDash = 3.0
var dashLength = 0.05
var thisDash = 0.0
var damageDash = 7

var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta


	var directionx := Input.get_axis("left", "right")
	if directionx:
		velocity.x = directionx * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var mouse := get_global_mouse_position()
	look_at(mouse)
	_sprite.rotation = -rotation
	_Hitbox.rotation = -rotation

	
	dash(delta)		


	if rotation > PI/2 or rotation < -PI/2:
		if directionx:
			_animation.play("walking_left")
		else:
			_animation.play("idle_left")

	else:
		if directionx:
			_animation.play("walking_right")
		else:
			_animation.play("idle_right")
			
			
	attack()
			
	move_and_slide()


func dash(delta: float):
	var click := Input.is_action_just_pressed("dash")
	lastDash += delta
	if canDash:
		thisDash += delta
	else:
		thisDash = 0.0	
		
	if lastDash > dashCooldown:
		if click && thisDash < dashCooldown:
			canDash = true

			thisDash = dashCooldown
	else:
		canDash = false
	if canDash:
		velocity.y = dashSPEEDy*sin(rotation)
		velocity.x = dashSPEEDx*cos(rotation)
		if thisDash > (dashCooldown + dashLength):
			lastDash = 0.0
			
			
func attack():
	var new_arrow_instance = ArrowScene.instantiate() 
	get_parent().add_child(new_arrow_instance)
	new_arrow_instance.global_position = global_position
