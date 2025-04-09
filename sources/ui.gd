extends CanvasLayer

func add_score(amount):
	Global.score += amount
	$MarginContainer/Label.text = "Score : " + str(Global.score)
