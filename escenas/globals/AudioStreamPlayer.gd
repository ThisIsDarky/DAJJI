extends AudioStreamPlayer
var volmusic = -24;
var music = "";
var SelectMusic;
func _ready():
	playMusic()
	volumenControl();

func playMusic():
	randomize()
	SelectMusic = round(rand_range(1,4));
	if SelectMusic == 1:
		music = "res://musica/music1.ogg";
	elif SelectMusic ==2:
		music = "res://musica/music2.ogg";
	elif SelectMusic ==3:
		music = "res://musica/music3.ogg";
	elif SelectMusic ==4:
		music = "res://musica/music4.ogg";
	var AmbientalMusic = load(music);
	stream = AmbientalMusic;
	play();
	print(SelectMusic)
	
func volumenControl():
	volmusic += GlobalVar.volMusic;
	volume_db = volmusic;
