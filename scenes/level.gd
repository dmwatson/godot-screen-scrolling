extends Node2D


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("dev_quit"):
		get_tree().quit()
	if event.is_action_pressed("fullscreen"):
		toggle_fullscreen()
	
func toggle_fullscreen() -> void:
	if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
