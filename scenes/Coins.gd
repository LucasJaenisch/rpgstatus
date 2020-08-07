extends Area2D

signal coin_grabbed(coin_value)
var coin_sound
var coin_value

func _ready():
	#coin_sound = "res://sounds/coins.wav"
	#$Sound.stream = load(coin_sound)
	connect("body_entered", self, "_on_Coins_body_entered")
	#connect("Onc", get_node("Main"), "_on_Coins_body_entered")

func _on_Coins_body_entered(body):
	if body.get_name() == "Player":
		#$Sound.play()
		emit_signal("coin_grabbed", coin_value)
		queue_free()
