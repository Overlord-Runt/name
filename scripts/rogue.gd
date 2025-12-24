extends CharacterBody2D

@onready var _animated_sprite = $AnimatedSprite2D
@onready var _Hitbox = $Hitbox

const SPEED = 300.0
const dashSPEED = 900.0
const JUMP_VELOCITY = -900.0
var canAttack = false
var dashCooldown = 0.3
var lastDash = 3.0
var dashLength = 0.05
var thisDash = 0.0


func _physics_process(delta: float) -> void:

	var directionx := Input.get_axis("left", "right")
	if directionx:
		velocity.x = directionx * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	var directiony := Input.get_axis("up", "down")
	if directiony:
		velocity.y = directiony * SPEED
	else:
		velocity.y = move_toward(velocity.x, 0, SPEED)
	var mouse := get_global_mouse_position()
	look_at(mouse)
	_animated_sprite.rotation = -rotation
	
	attack(delta)		
	
	move_and_slide()


	if rotation > PI/2 or rotation < -PI/2:
		_animated_sprite.play("default-left")
		_Hitbox.position.x = 8
	else:
		_animated_sprite.play("default-right")
		_Hitbox.position.x = -8


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
			thisDash = dashCooldown
	else:
		canAttack = false
	if canAttack:
		velocity.y = dashSPEED*sin(rotation)
		velocity.x = dashSPEED*cos(rotation)
		if thisDash > (dashCooldown + dashLength):
			lastDash = 0.0
	
