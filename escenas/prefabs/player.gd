extends KinematicBody2D
# variables del player
var velocidad;
var inicio = true;
var direccion = "";
var limite;
var loadPowerUp = 0;
var e = false;
var touch = false;
var volEfects = 0;
#señales emitidas al mundo
signal golpePlaneta;
signal golpeSupernova;
signal golpeBatery;


func _ready():
	velocidad = GlobalVar.GlobalVelocityPlayer;
	limite = get_viewport_rect().size;
	inicio = true;
	direccion = "right"
	loadPowerUp = 0;
	$powerUp.visible = false;
	$Sprite.visible = true;
	controlSonido();

func _process(delta):
	velocidad = GlobalVar.GlobalVelocityPlayer;
	GlobalVar.LoadPowerUp = loadPowerUp;
	if GlobalVar.PowerUp > 0:
		$powerUp.visible = true;
		$AnimationPlayer.play("girarEscudo");
	else:
		$powerUp.visible = false;
		$AnimationPlayer.stop()

	if Input.is_action_just_pressed("ui_down") or touch == true:
		inicio = false;
		loadPowerUpBar();
		if direccion == "right":
			direccion = "left"
		elif direccion == "left":
			direccion = "right"
		touch = false;
	
	
	if inicio == true && GlobalVar.StopGame == false:
		move_and_slide(Vector2(0,-1)*velocidad);
	else:
		moverPlayer();
	
	position.x = clamp(position.x,0,limite.x)
	
	
	
	#evitar que el sonido del escudo se repita
	if e == true:
		yield(get_tree().create_timer(1),"timeout");
		$efecto.playing = false;
		e = false;



func loadPowerUpBar():
	if loadPowerUp < 30 && GlobalVar.StopGame == false :
		loadPowerUp += 1;
	else:
		loadPowerUp = 0
	if GlobalVar.LoadPowerUp == 30:
			GlobalVar.PowerUp += 1
			$efecto.playing = true;
			e = true;

func moverPlayer():
	if GlobalVar.StopGame == false:
		if direccion == "left":
			move_and_slide(Vector2(-1,-1)*velocidad);
			rotation_degrees = -45
		if direccion =="right":
			move_and_slide(Vector2(1,-1)*velocidad);
			rotation_degrees = 45
		GlobalVar.positionPlayer = position;


func playerGameOver():
	$GameOverParticles.emitting = true;
	$GameOverParticles2.emitting = true;
	$GameOverParticles3.emitting = true;
	$Sprite.visible = false;

func _input(event):
	if event is InputEventScreenTouch:
		if event.pressed == true :
			touch = true;
		else:
			touch = false;
	


func _on_Player2_area_entered(area):

	if ('supernova' in area.name) == true:
		emit_signal("golpeSupernova");
	elif ('enemi' in area.name) == true:
		emit_signal("golpePlaneta");
	elif ('Batery' in area.name) == true:
		emit_signal("golpeBatery");

func controlSonido():
	volEfects =+ GlobalVar.volEfect;
	$efecto.volume_db = volEfects;
