extends Node
var music_player = AudioStreamPlayer.new()
func _ready():
	add_child(music_player)
	music_player.bus = "Music" 

func play_music(nova_musica: AudioStream):
	if music_player.stream == nova_musica:
		return 
	
	music_player.stream = nova_musica
	music_player.play()
	
func play_sfx(som: AudioStream):
	var sfx_player = AudioStreamPlayer.new()
	sfx_player.stream = som
	sfx_player.bus = "SFX"
	add_child(sfx_player)
	sfx_player.play()
	
	sfx_player.finished.connect(sfx_player.queue_free)
