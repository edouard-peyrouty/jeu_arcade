extends Node2D

var cookie_scene:PackedScene = load("res://cookie.tscn")
var player_scene:PackedScene = load("res://player.tscn")
var bombe_scene:PackedScene = load("res://bombe.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.score = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# génère les cookies à intervalles réguliers
func _on_timer_cookies_timeout() -> void:
	var cookie = cookie_scene.instantiate()
	if cookie != null: 
		$cookies.add_child(cookie)
	cookie.connect("collision", _on_cookie_collision)

# quand on mange un cookie
func _on_cookie_collision() -> void:
	get_tree().call_group("ui", "add_score", 100)
	$eatCookie.seek(0.47)  # Commence la lecture après 0.47 secondes
	$eatCookie.play()  # Joue le son

# génère les bombes à intervalles réguliers
func _on_timer_bombes_timeout() -> void:
	var bombe = bombe_scene.instantiate()
	if bombe != null:
		$bombes.add_child(bombe)
	bombe.connect("explosion", _on_bombe_collision)

# quand on est touché par une bombe
func _on_bombe_collision() -> void:
		get_tree().change_scene_to_file("res://game_over.tscn")
