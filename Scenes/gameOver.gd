extends Control
var dir_main_menu=load("res://Scenes/Menu/menuPrincipal.tscn")

@export var SignPosition : Vector2 = Vector2(320, 141)
@export var SignColor : Color = Color.WHITE
var revive_price = 50
var coins

func _ready():
	get_tree().paused=true
	create_tween().tween_property($Sign, "position", SignPosition, 1)
	create_tween().tween_property($Background, "modulate", SignColor, 1)
	coins = Save.LoadCoins()
	$ColorRect/Coins.text = str(coins)
	
func _on_revivir_pressed():
	if coins < revive_price:
		$AnimationPlayer.play("show_error")
		return
	Save.SaveCoins(coins - revive_price)
	get_tree().paused=false
	GameController.Resurrect()
	GameEvents.OnSetVisible.Call([true])
	queue_free()


func _on_main_menu_pressed():
	get_tree().paused=false
	get_tree().change_scene_to_packed(dir_main_menu)
