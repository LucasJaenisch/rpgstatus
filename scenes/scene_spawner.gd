extends Node

var rand = RandomNumberGenerator.new()
var hero_scene = load("res://scenes/hero.tscn")
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

func auto_spawn_entities(i):
	var hero = hero_scene.instance()
	rand.randomize()
	var x = rand.randf_range(0, screen_size.x)
	rand.randomize()
	var y = rand.randf_range(0, screen_size.y)
	
	hero.my_stats = json_result[String(i)]
	hero.position.y = y
	hero.position.x = x
	add_child(hero)
