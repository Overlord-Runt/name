extends CharacterBody2D


const SPEED = 300.0
const dashSPEED = 900.0
const JUMP_VELOCITY = -900.0
var dashLength = 0.2
var dashCooldown = 1.0
var lastDash = 2.0


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
	
	dash()		
	
	move_and_slide()


func dash():
	var click := Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)
	if click && lastDash > dashCooldown:
		lastDash = get_tree().create_timer(2)
		velocity.y = dashSPEED*sin(rotation)
		velocity.x = dashSPEED*cos(rotation)
	if lastDash < dashLength:
			velocity.y = dashSPEED*sin(rotation)
			velocity.x = dashSPEED*cos(rotation)
