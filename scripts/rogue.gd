extends CharacterBody2D

@onready var _sprite = $Sprite2D
@onready var _Hitbox = $Hitbox
@onready var _animation = $AnimationPlayer

const SPEED = 300.0
const dashSPEEDy = 900.0
const dashSPEEDx = 1300.0
const JUMP_VELOCITY = -900.0

var canAttack = false
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

	
	attack(delta)		
	
	move_and_slide()


	if rotation > PI/2 or rotation < -PI/2:
		_animation.play("idle_left")
		_Hitbox.global_position.x = _sprite.global_position.x
		_Hitbox.global_position.y = _sprite.global_position.y + 8
	else:
		_animation.play("idle_right")
		_Hitbox.global_position.x = _sprite.global_position.x
		_Hitbox.global_position.y = _sprite.global_position.y + 8


func attack(delta: float):
	var click := Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)
	lastDash += delta
	if canAttack:
		thisDash += delta
	else:
		thisDash = 0.0	
		
	if lastDash > dashCooldown:
		if click && thisDash < dashCooldown:
			canAttack = true
			_animation.play("Attack_left")
			thisDash = dashCooldown
	else:
		canAttack = false
	if canAttack:
		velocity.y = dashSPEEDy*sin(rotation)
		velocity.x = dashSPEEDx*cos(rotation)
		if thisDash > (dashCooldown + dashLength):
			lastDash = 0.0
	
