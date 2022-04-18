extends Node2D

var txt = '';
func _ready():
	$AnimationPlayer.play("girar");
	$AnimationPlayer.play("btnhover");



func cargarPopup(cargar):
	$info/showHelp/Label.text = cargar;
	$info/showHelp.popup();


func _on_infoPlaneta_pressed():
	txt = 'Los planetas son grandes y \n robustos, pero con la carga de un \n escudo interestelar será suficiente \n para destruirlos sin sufrir daños';
	cargarPopup(txt);


func _on_btnVolver_pressed():
	GlobalTransition.change_scene('res://escenas/interfaz/Home.tscn')


func _on_infoSuperNova_pressed():
	txt = 'Las supernovas liberan una gran \n cantidad de energía por ello será \n difícil atravesar una, necesitarás 3 \n escudos para poder atravesar una \n sin sufrir daños ';
	cargarPopup(txt);


func _on_infoEscudo_pressed():
	txt = 'Los escudos de poder se cargan al \n dar saltos en el espacio, toca la \n pantalla para cargar la barra de \n escudo o toma una batería de poder \n para cargar escudos';
	cargarPopup(txt);


func _on_infoBatery_pressed():
	txt = 'Las baterías fueron soltadas en el \n espacio al recogerlas te serán \n otorgados 2 escudos inter estelares \n utilízalos sabiamente';
	cargarPopup(txt);
