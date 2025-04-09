extends Node2D

var cookie_scene:PackedScene = load("res://cookie.tscn")
var player_scene:PackedScene = load("res://player.tscn")
var bombe_scene:PackedScene = load("res://bombe.tscn")

var AffichageTimerMax: Label  # Pour afficher le temps
var TimerTempsMax: Timer  # Le Timer qui gère le décompte du temps
var time_left: int = 30 # Temps restant en secondes (1 minute)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Création du Timer
	TimerTempsMax = Timer.new()
	add_child(TimerTempsMax)
	TimerTempsMax.wait_time = 1  # Le timer se déclenchera toutes les secondes
	TimerTempsMax.one_shot = false  # Le timer se répète toutes les secondes
	TimerTempsMax.connect("timeout", Callable(self, "_on_timer_temps_max_timeout"))

	TimerTempsMax.start()  # Lance le timer
	
	
	# Création du Label
	AffichageTimerMax = Label.new()
	add_child(AffichageTimerMax)
	AffichageTimerMax.text = "Temps restant: " + str(time_left)  # Affichage initial du temps restant
	
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

func _on_bombe_collision() -> void:
	get_tree().change_scene_to_file("res://game_overTimed.tscn")


func _on_timer_temps_max_timeout() -> void:
   	# Décrémenter le temps restant
	time_left -= 1
   	# Mettre à jour l'affichage
	AffichageTimerMax.text = "Temps restant: " + str(time_left)

	if time_left == 20:
		$Timer_cookies.wait_time = 1.2
		$Timer_cookies.start()
		
		$Timer_bombes.wait_time = 0.9
		$Timer_bombes.start()
		

	if time_left == 10:
		$Timer_cookies.wait_time = 1.8
		$Timer_cookies.start()
		
		$Timer_bombes.wait_time = 0.6
		$Timer_bombes.start()
		
	if time_left == 5:
		$Timer_cookies.wait_time = 0.2
		$Timer_cookies.start()
		
		$Timer_bombes.wait_time = 0.4
		$Timer_bombes.start()
		
	if time_left == 3:
		$Timer_cookies.wait_time = 0.5
		$Timer_cookies.start()
		
		$Timer_bombes.wait_time = 0.5
		$Timer_bombes.start()



	# Si le temps est écoulé (time_left == 0)
	if time_left == 10:
		$BIP.play()
	
	if time_left <= 0:
		_on_timer_end()  # Appeler la fonction de fin de timer

# Fonction qui sera appelée lorsque le temps est écoulé
func _on_timer_end() -> void:
	print("1 minute écoulée !")  
	get_tree().change_scene_to_file("res://EndChronometreBackground.tscn")

	
