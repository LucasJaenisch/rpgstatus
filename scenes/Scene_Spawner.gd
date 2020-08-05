extends Node

var rand = RandomNumberGenerator.new()
var enemy_scene = load("res://scenes/Enemy.tscn")
var player_scene = load("res://scenes/Player.tscn")
var screen_size

var json_result = {}

var stats = {}

func _ready():
	screen_size = get_viewport().get_visible_rect().size
	
	var file = File.new()
	file.open("res://save/heroes.json", file.READ)
	var json = file.get_as_text()
	json_result = JSON.parse(json).result
	file.close()
	
	var i = 1
	while i < json_result.size() + 1:
		auto_spawn_entities(i)
		i += 1
	
	var player = player_scene.instance()
	player.my_stats = json_result["1"]
	add_child(player)

func auto_spawn_entities(i):
	var enemy = enemy_scene.instance()
	rand.randomize()
	var x = rand.randf_range(0, screen_size.x)
	rand.randomize()
	var y = rand.randf_range(0, screen_size.y)
	
	enemy.my_stats = json_result[String(i)]
	enemy.position.y = y
	enemy.position.x = x
	add_child(enemy)
