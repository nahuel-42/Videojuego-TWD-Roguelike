extends Node

var musicaMenuPrincipal = load("res://Assets/Audios/Destino - Despearate OST (1).mp3")
var musicaMapa= load("res://Assets/Audios/Desesperación-Despearate-OST.mp3")
var audio_player = AudioStreamPlayer.new()
var audio_player_mapa = AudioStreamPlayer.new()
func _ready():
	audio_player.stream = musicaMenuPrincipal
	audio_player_mapa.stream = musicaMapa
	add_child(audio_player)
	add_child(audio_player_mapa)
	audio_player_mapa.volume_db = -10
	playMusicaMenuPrincipal()


func playMusicaMapa():
	if not audio_player_mapa.playing:
		audio_player_mapa.play()

func stopMusicaMapa():
	if audio_player_mapa.playing:
		audio_player_mapa.stop()

func playMusicaMenuPrincipal():
	if not audio_player.playing:
		audio_player.play()

func stopMusicaMenuPrincipal():
	if audio_player.playing:
		audio_player.stop()
