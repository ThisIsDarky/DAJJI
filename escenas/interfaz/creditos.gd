extends CanvasLayer


func _ready():
	$lblBonus.text = "Bonus: " + str(GlobalVar.Bonus);
	$lblScore.text = "Score: " + str(GlobalVar.GlobalScore);
	$lblTotal.text = "Total: " + str(GlobalVar.Bonus + GlobalVar.GlobalScore);
	$animarButton.play("animarBtn")


func _on_btnVolver_pressed():
	$lblBonus.visible = false;
	$lblScore.visible = false;
	$lblTotal.visible = false;
	$lblNameGame.visible = false;
	$btnMenu.visible = false;
	$btnVolver.visible = false;
	reiniciarGlobalVar();
	GlobalTransition.change_scene("res://escenas/mundo.tscn");


func _on_btnMenu_pressed():
	$lblBonus.visible = false;
	$lblScore.visible = false;
	$lblTotal.visible = false;
	$lblNameGame.visible = false;
	$btnMenu.visible = false;
	$btnVolver.visible = false;
	reiniciarGlobalVar();
	GlobalTransition.change_scene("res://escenas/interfaz/Home.tscn");
	
func reiniciarGlobalVar():
	GlobalVar.StopGame = false;
	GlobalVar.ShowEnemys = 0;
	GlobalVar.LoadPowerUp = 0;
	GlobalVar.PowerUp = 0;
	GlobalVar.GlobalScore = 0;
	GlobalVar.Bonus = 0;
	GlobalVar.GlobalVelocityPlayer = 400;
