extends Control

func _on_Start_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Levels/Tutorial.tscn")

func _on_Options_pressed():
	pass # Replace with function body.

func _on_Quit_pressed():
	get_tree().quit()
