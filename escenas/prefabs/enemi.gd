extends Area2D

var selectEnemiAnimation;
var slowPts = false;
var volEfects = 3;
onready var animarPlayer = $AnimationPlayer;
onready var explosion1 = $explosion/CPUParticles2D;
onready var explosion2 = $explosion/CPUParticles2D2;
onready var efectoSonido = $efecto;
onready var SkinPlayer = $Sprite;
onready var colisionPlayer = $CollisionShape2D;

func _ready():
	randomize();
	selectEnemiAnimation = round(rand_range(1,2));
	if selectEnemiAnimation == 1:
		animarPlayer.play("girar");
	else:
		animarPlayer.play("girarInvert");
	controlSonido();





func _on_VisibilityNotifier2D_screen_exited():
	GlobalVar.ShowEnemys -= 1;
	queue_free()
	




func _on_enemi_area_entered(area):
	if area.name == "Player2" && slowPts == false:
		if GlobalVar.PowerUp > 0:
			explosion1.emitting = true;
			explosion2.emitting = true;
			efectoSonido.playing = true;
			SkinPlayer.visible = false;
			colisionPlayer.disabled = true
			
		else:
			queue_free();
			
func controlSonido():
	volEfects =+ GlobalVar.volEfect;
	$efecto.volume_db = volEfects;
