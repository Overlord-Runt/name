extends CharacterBody2D

var SPEED = 300



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var mouse := get_global_mouse_position()
	look_at(mouse)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	velocity.x = SPEED*sin(rotation)
	velocity.y = SPEED*cos(rotation)
	if not $VisibleOnScreenNotifier2D.is_on_screen():
		queue_free()
	
	move_and_slide()
