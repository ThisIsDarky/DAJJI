extends Area2D


var movimiento = Vector2();
var velocidad = 220;
var volEfects = 0;

 
func _ready():
	$anima.play("girar");
	controlSonido();

func _physics_process(delta):
	movimiento = Vector2();
	var bodies = $Vigilante.get_overlapping_bodies();
	
	for body in bodies:
		if body.name == "player":
			perseguirPlayer(delta);

func perseguirPlayer(d):
	if GlobalVar.positionPlayer.x > position.x:
		movimiento.x += 1;
	elif GlobalVar.positionPlayer.x < position.x:
		movimiento.x -= 1;
	
	if GlobalVar.positionPlayer.y > position.y:
		movimiento.y += 1;
	elif GlobalVar.positionPlayer.y < position.y:
		movimiento.y -= 1;
	
	if movimiento.length() > 0:
		movimiento = movimiento.normalized() * velocidad;
		
	position += movimiento * d;

func controlSonido():
	volEfects =+ GlobalVar.volEfect;
	$anim.volume_db = volEfects;



func _on_VisibilityNotifier2D_screen_exited():
	GlobalVar.ShowSuperNova -= 1;
	queue_free();


func _on_supernova_area_entered(area):
	if area.name == "Player2":
			$CollisionShape2D.disabled = true;
			$anima.stop()
			$explosion/CPUParticles2D.emitting = true;
			$explosion/CPUParticles2D2.emitting = true;
			$Sprite.visible = false;
			$anim.playing = true;
			yield(get_tree().create_timer(0.5),"timeout");
			hide()
		
