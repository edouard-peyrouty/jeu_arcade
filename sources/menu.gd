extends Control

@onready var first_scene = preload("res://level.tscn")
@onready var second_scene = preload("res://levelTimed.tscn")



func _on_start_btn_button_down() -> void:
	get_tree().change_scene_to_packed(first_scene)


func _on_quit_btn_button_down() -> void:
	get_tree().quit()


func _on_btn_start_timed_button_down() -> void:
	get_tree().change_scene_to_packed(second_scene)
