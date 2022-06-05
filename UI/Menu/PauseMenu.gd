extends Control

var is_pause = false setget set_is_paused

func _unhandled_input(event):
	if event.is_action_pressed("pause"):
		self.is_pause = !is_pause

func set_is_paused(value):
	is_pause = value
	get_tree().paused = is_pause
	visible = is_pause

func _on_Resume_pressed():
	self.is_pause = false

func _on_Menu_pressed():
	self.is_pause = false
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://UI/Menu/Menu.tscn")

func _on_Quit_pressed():
	get_tree().quit()


