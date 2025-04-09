extends CanvasLayer

var pause = false

func pause_unpause():
	pause = !pause
	
	if pause:
		get_tree().paused = true
		show()
	else:
		get_tree().paused = false
		hide()
	
func _input(event):
	if event.is_action_pressed("escape"):
		pause_unpause()



func _on_btn_menu_principal_button_down() -> void:
	get_tree().paused = false  # Important pour désactiver la pause avant de changer de scène
	get_tree().change_scene_to_file("res://Menu.tscn")  # ou le bon chemin


func _on_btn_quit_button_down() -> void:
	get_tree().quit()
