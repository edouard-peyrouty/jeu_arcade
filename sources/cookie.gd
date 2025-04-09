extends Area2D

signal collision

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

# gère les cookies qui entrent alors que la bouche est ouverte
func _on_body_entered(body: Node2D) -> void:
	# La collision entre le cookie et le chat ne marche que si ce dernier a la bouche ouverte
	if(body.can_eat):
		collision.emit()
		# le cookie disparait
		self.queue_free()
