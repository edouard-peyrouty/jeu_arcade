extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$CenterContainer/VBoxContainer/Label2.text = "Score : " + str(Global.score)
	$AudioStreamPlayer2D.play()
	$AudioStreamPlayer2D.seek(0.90) 
	Global.score = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("space"):
		get_tree().change_scene_to_file("res://level.tscn")
