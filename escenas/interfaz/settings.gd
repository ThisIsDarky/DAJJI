extends CanvasLayer

var contMusic;
var contEfects;

# Called when the node enters the scene tree for the first time.
func _ready():
	$volSoundtrack.value = GlobalVar.volMusic;
	$volEfect.value = GlobalVar.volEfect;
	$animar.play("moon")



func _process(delta):
	contMusic = $volSoundtrack.value;
	GlobalVar.volMusic = contMusic;
	
	contEfects = $volEfect.value;
	GlobalVar.volEfect = contEfects;


func _on_Button_pressed():
	$fondoadorn/fondo.visible = false;
	$fondoadorn/estrellas.visible = false;
	$fondoadorn/moon.visible = false;
	
	GlobalTransition.change_scene('res://escenas/interfaz/Home.tscn')


