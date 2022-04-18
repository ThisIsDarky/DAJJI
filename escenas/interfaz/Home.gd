extends CanvasLayer


func _ready():
	$animar.play("BtnAnimation");
	



func _on_Btnplay_pressed():
	transition();
	GlobalTransition.change_scene("res://escenas/mundo.tscn");


func _on_BtnSettings_pressed():
	transition();
	GlobalTransition.change_scene("res://escenas/interfaz/settings.tscn");


func transition():
	$lblNameGame.visible = false;
	$Btnplay.visible = false;
	$BtnSettings.visible = false;
	$BtnHelp.visible = false;
	$animar.play("offset");


func _on_BtnHelp_pressed():
	transition();
	GlobalTransition.change_scene("res://escenas/interfaz/help.tscn");
