extends Node

var rand = RandomNumberGenerator.new()
var enemy_scene = load("res://scenes/Enemy.tscn")
var player_scene = load("res://scenes/Player.tscn")
var coin_scene = load("res://scenes/Coins.tscn")

var screen_size
var score = 0

var json_result = {}
var stats = {}

signal coin_grabbed

func _ready():
	rand.randomize()
	screen_size = get_viewport().get_visible_rect().size
	var file = File.new()
	file.open("res://save/heroes.json", file.READ)
	var json = file.get_as_text()
	json_result = JSON.parse(json).result
	file.close()
	
	#var i = 1
	#while i < json_result.size() + 1:
	#	spawn_enemy(i)
	#	i += 1
		
	spawn_player()
	spawn_enemy(2, 50, 50)
	#spawn_enemy(1, 10, 10)
	#spawn_enemy(3, 100, 100)
	spawn_coins(5, 50, Color(0,1,0))
	spawn_coins(5, 100, Color(1,1,0))
	
func spawn_enemy(id, x, y):
	var enemy = enemy_scene.instance()
	enemy.my_stats = json_result[String(id)]
	enemy.sprite = load(enemy.my_stats.icon)
	enemy.get_node("Pivot/Sprite").texture = enemy.sprite
	enemy.get_node("Shadow").texture = enemy.sprite
	enemy.position.y = y
	enemy.position.x = x
	add_child(enemy)

func spawn_enemies(i):
	var enemy = enemy_scene.instance()
	rand.randomize()
	var x = rand.randf_range(0, screen_size.x)
	rand.randomize()
	var y = rand.randf_range(0, screen_size.y)
	
	enemy.my_stats = json_result[String(i)]
	enemy.sprite = load(enemy.my_stats.icon)
	enemy.get_node("Pivot/Sprite").texture = enemy.sprite
	enemy.get_node("Shadow").texture = enemy.sprite
	enemy.position.y = y
	enemy.position.x = x
	add_child(enemy)
	
func spawn_coins(amount, value, color):
	for i in range(amount):
		var coin = coin_scene.instance()
		rand.randomize()
		var x = rand.randf_range(0, screen_size.x)
		rand.randomize()
		var y = rand.randf_range(0, screen_size.y)
		coin.connect("coin_grabbed", get_node("Player"), "on_coin_grabbed")
		coin.coin_value = value
		coin.get_node("Sprite").modulate = color
		coin.position.x = x
		coin.position.y = y
		add_child(coin)
		
func spawn_player():
	var player = player_scene.instance()
	player.my_stats = json_result["1"]
	player.sprite = load(player.my_stats.icon)
	player.get_node("Pivot/Sprite").texture = player.sprite
	player.get_node("Shadow").texture = player.sprite
	add_child(player)
	

