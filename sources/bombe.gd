extends Area2D

signal explosion

@export var vitesse := 300

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var rng = RandomNumberGenerator.new()
	var width = get_viewport().get_visible_rect().size[0]
	var random_x = rng.randi_range(50, width-50)
	position = Vector2(random_x, 0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.y += vitesse * delta

func _on_body_entered(body: Node2D) -> void:
	# La collision entre la bombe et le chat ne marche que si ce dernier a la bouche fermée
	if(!body.can_eat):
		explosion.emit()
	# sinon la bombe disparait
	else:
		self.queue_free() 
		get_tree().call_group("ui", "add_score", -100)  
