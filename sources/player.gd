extends CharacterBody2D

@export var vitesse := 800
@export var texture_bouche_fermee: Texture2D
@export var texture_bouche_ouverte: Texture2D

var can_eat := false

func _ready() -> void:
	position = Vector2(100, 600)
	fermer_bouche()

func _process(delta: float) -> void:
	
	# déplacements
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity.x = direction.x * vitesse
	velocity.y = 0
	move_and_slide()
	
	# ouverture de la bouche
	if Input.is_action_just_pressed("space"):
		ouvrir_bouche()
	
	# fermeture de la bouche
	if Input.is_action_just_released("space"):
		fermer_bouche()
		
	# on fait avancer la gauge de bouche ouverte
	if can_eat:
		$ProgressBar.value = 1.0 - ($timer_bouche_ouverte.time_left / $timer_bouche_ouverte.wait_time)		

# ferme la bouche
func fermer_bouche():
	$Sprite2D.texture = texture_bouche_fermee
	can_eat = false
	$ProgressBar.value = 0
	$ProgressBar.visible = false

# ouvre la bouche
func ouvrir_bouche():
	$Sprite2D.texture = texture_bouche_ouverte
	can_eat = true
	$timer_bouche_ouverte.start()
	$ProgressBar.visible = true
	
	$AudioBouche.play()  # Joue le son
	await get_tree().create_timer(1.0).timeout  # Attends 1 seconde
	$AudioBouche.stop()

# empêche de maintenir la bouche ouverte en permanence
func _on_timer_bouche_ouverte_timeout() -> void:
	fermer_bouche()
