extends Node

func hurt_player(caller):
	var audio_stream = create_audio_stream(caller)
	audio_stream.stream = preload("res://Sounds/Hurt.wav")
	audio_stream.play()
	
func create_audio_stream(caller):
	var audio_stream = AudioStreamPlayer.new()
	audio_stream.set_name("audio_stream")
	caller.add_child(audio_stream)
	return audio_stream
