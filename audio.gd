extends Node

var musicaMenuPrincipal = load("res://Assets/Audios/Destino - Despearate OST (1).mp3")
var musicaMapa= load("res://Assets/Audios/Desesperación-Despearate-OST.mp3")
var audio_player = AudioStreamPlayer.new()
var audio_player_mapa = AudioStreamPlayer.new()

var in_game_sounds = []
var sounds_dictionary = {
	"bowShot": 0,
	"fireballExplosion": 1,
	"fireballFlying": 2,
	"iceballExplosion": 3,
	"iceballFlying": 4
}

func _ready():
	load_sfx()
	audio_player.stream = musicaMenuPrincipal
	audio_player_mapa.stream = musicaMapa
	add_child(audio_player)
	add_child(audio_player_mapa)
	audio_player_mapa.volume_db = -10
	playMusicaMenuPrincipal()

func load_sfx():
	in_game_sounds.append(load("res://Assets/Audios/InGameSFX/bowShot.wav") as AudioStream)
	in_game_sounds.append(load("res://Assets/Audios/InGameSFX/fireballExplosion.mp3") as AudioStream)
	in_game_sounds.append(load("res://Assets/Audios/InGameSFX/fireballFlying.wav") as AudioStream)
	in_game_sounds.append(load("res://Assets/Audios/InGameSFX/iceballExplosion.wav") as AudioStream)
	in_game_sounds.append(load("res://Assets/Audios/InGameSFX/iceballFlying.wav") as AudioStream)

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

func getSFX(name):
	return in_game_sounds[sounds_dictionary[name]]
