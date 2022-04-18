extends CanvasLayer


func change_scene(scene):
	$animarTransition.play("fade in");
	yield($animarTransition, "animation_finished");
	
	get_tree().change_scene(scene);
	$animarTransition.play("fade out");
