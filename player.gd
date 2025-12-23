extends CharacterBody2D


const SPEED = 300.0
const dashSPEED = 900.0
const JUMP_VELOCITY = -900.0


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
	
	var click := Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)
	if click:
		velocity.y = dashSPEED*sin(rotation)
		velocity.x = dashSPEED*cos(rotation)
	
	
	move_and_slide()
