extends Node2D
#Variables instansiadas
export(PackedScene) var enemy;
export(PackedScene) var supernova;
export(PackedScene) var batery;
#variables locales
var limite;
var positionAfterEnemyX = 0;
var positionAfterEnemyY = 0;
var Score = 0;
var drawSuperNova = 0;
var drawBatery = 0;
var startGame = false;
var stopLearn = false;
var rangoTextWOW = 0;
var rtw = false;


#variables referentes a los nodos
onready var lblGameOver = $interfaz/GameOver;
onready var lblScore = $interfaz/LblScore;
onready var lblNumPowerUp = $interfaz/LblNumPowerUP;
onready var progresPowerUp = $interfaz/pbrPowerUP;
onready var ScoreTimer = $Score;
onready var player = $player;

func _ready():
	startGame = false;
	limite = get_viewport_rect().size;
	lblGameOver.visible = false;
	ScoreTimer.start();
	lblScore.text = "0";
	progresPowerUp.value = GlobalVar.LoadPowerUp;


func _process(delta):

	progresPowerUp.value = GlobalVar.LoadPowerUp;
	lblNumPowerUp.text = "x" + str(GlobalVar.PowerUp)
	
	if GlobalVar.StopGame == false:
		if GlobalVar.ShowEnemys < 5 && startGame == true:
			drawEnemigo();
		randomize()
		drawSuperNova = round(rand_range(1,10));
		if drawSuperNova > 8 && GlobalVar.GlobalScore > 10 && GlobalVar.ShowSuperNova < 1:
			drawSuperNova();
			
		randomize()
		drawBatery = round(rand_range(1,100));
		if drawBatery > 99 && GlobalVar.GlobalScore > 20 && GlobalVar.ShowBatery < 1:
			drawBatery();
	
	drawWOWText();



func drawSuperNova():
	var sn = supernova.instance();
	randomize();
	sn.position.x = (round(rand_range(20,(int(limite.x)-20))));
	sn.position.y = (round(rand_range((int(player.position.y)-405),(int(player.position.y)-505))))
	
	if sn.position.x > (positionAfterEnemyX + 40) or sn.position.x < (positionAfterEnemyX-40) :
		if sn.position.y < (positionAfterEnemyY-60):
			positionAfterEnemyX = sn.position.x
			positionAfterEnemyY = sn.position.y
			add_child(sn);
			GlobalVar.ShowSuperNova += 1;

func drawEnemigo():
	var enemigo = enemy.instance();
	randomize();
	enemigo.position.x = (round(rand_range(20,(int(limite.x)-20))));
	enemigo.position.y = (round(rand_range((int(player.position.y)-305),(int(player.position.y)-505))))
	
	if enemigo.position.x > (positionAfterEnemyX + 40) or enemigo.position.x < (positionAfterEnemyX-40) :
		if enemigo.position.y < (positionAfterEnemyY-60):
			positionAfterEnemyX = enemigo.position.x
			positionAfterEnemyY = enemigo.position.y
			GlobalVar.ShowEnemys += 1;
			add_child(enemigo);

func drawBatery():
	var bt = batery.instance();
	randomize();
	bt.position.x = (round(rand_range(20,(int(limite.x)-20))));
	bt.position.y = (round(rand_range((int(player.position.y)-405),(int(player.position.y)-505))))
	
	if bt.position.x > (positionAfterEnemyX + 40) or bt.position.x < (positionAfterEnemyX-40) :
		if bt.position.y < (positionAfterEnemyY-60):
			positionAfterEnemyX = bt.position.x
			positionAfterEnemyY = bt.position.y
			add_child(bt);
			GlobalVar.ShowBatery += 1;

func drawWOWText():
	if rtw == false:
		randomize();
		rangoTextWOW = round(rand_range((GlobalVar.Bonus + 100),(GlobalVar.Bonus + 500)));
		rtw = true;
	if GlobalVar.Bonus > rangoTextWOW:
		$interfaz/text/W.visible = true;
		$interfaz/text/O.visible = true;
		$interfaz/text/W2.visible = true;
		$animartext.play("animarWOW!");
		yield($animartext, "animation_finished");
		$interfaz/text/W.visible = false;
		$interfaz/text/O.visible = false;
		$interfaz/text/W2.visible = false;
		rtw = false;

func colisionGame(lvlPower, objetoGolpeado):
	if lvlPower == 0 && objetoGolpeado == "planeta":
		game_over()
	elif lvlPower < 3 && objetoGolpeado == "superNova":
		game_over()
	else:
		if objetoGolpeado == "planeta":
			GlobalVar.PowerUp -= 1;
			GlobalVar.GlobalVelocityPlayer = 300;
			$controlSlow.start();
			GlobalVar.Bonus += 20; 
		elif objetoGolpeado == "superNova":
			GlobalVar.PowerUp -= 3;
			GlobalVar.GlobalVelocityPlayer = 250;
			$controlSlow.start();
			GlobalVar.Bonus += 30; 

func game_over():
	GlobalVar.StopGame = true;
	GlobalVar.GlobalVelocityPlayer = 0;
	$player.playerGameOver();
	ScoreTimer.stop();
	yield(get_tree().create_timer(0.5),"timeout");
	lblGameOver.visible = true;
	yield(get_tree().create_timer(0.5),"timeout");
	GlobalTransition.change_scene('res://escenas/interfaz/creditos.tscn')

func _on_Score_timeout():
	GlobalVar.GlobalScore += 1;
	lblScore.text = str(GlobalVar.GlobalScore);



func _on_StartGame_timeout():
	startGame = true;



#señales recibidas del player
func _on_player_golpePlaneta():
	colisionGame(GlobalVar.PowerUp, "planeta");

func _on_player_golpeSupernova():
	colisionGame(GlobalVar.PowerUp, "superNova");

func _on_player_golpeBatery():
	GlobalVar.PowerUp += 2;

func _on_controlSlow_timeout():
	if GlobalVar.StopGame == false:
		GlobalVar.GlobalVelocityPlayer = 400;
