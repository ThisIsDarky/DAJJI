extends KinematicBody2D


var velocidad = 400;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	move_and_slide(Vector2(0,-1)*velocidad);
