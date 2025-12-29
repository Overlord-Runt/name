extends CharacterBody2D

@onready var _sprite = $Sprite2D
@onready var _hitbox = $Hitbox

const SPEED = 100.0
const health = 20

func _physics_process(delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	look_at(get_node("/root/Node/Player").global_position)
	var speedY = SPEED*sin(rotation)
	var speedX = SPEED*cos(rotation)
	
	velocity.x = speedX
	velocity.y = speedY
	_sprite.rotation = -rotation
	_hitbox.rotation = -rotation

	move_and_slide()
