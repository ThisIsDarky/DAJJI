extends Area2D

var movimiento = Vector2();
var velocidad = 150;
var morePower = false;
var volEfects = 0;

# Called when the node enters the scene tree for the first time.
func _ready():
	controlSonido();


func _physics_process(delta):
	movimiento = Vector2();
	var bodies = $vigilante.get_overlapping_bodies();
	$AnimationPlayer.play("bateryAnim")
	for body in bodies:
		if body.name == "player":
			perseguirPlayer(delta);

func perseguirPlayer(d):
	if GlobalVar.positionPlayer.x > position.x:
		movimiento.x -= 1;
	elif GlobalVar.positionPlayer.x < position.x:
		movimiento.x += 1;
	
	if GlobalVar.positionPlayer.y > position.y:
		movimiento.y -= 1;
	elif GlobalVar.positionPlayer.y < position.y:
		movimiento.y += 1;
	
	if movimiento.length() > 0:
		movimiento = movimiento.normalized() * velocidad;
		
	position += movimiento * d;


func controlSonido():
	volEfects =+ GlobalVar.volEfect;
	$sund.volume_db = volEfects;


func _on_VisibilityNotifier2D_screen_exited():
	GlobalVar.ShowBatery -= 1
	queue_free()


func _on_Batery_area_entered(area):
	if area.name == "Player2" && morePower == false:
		$sund.playing = true;
		morePower = true;
