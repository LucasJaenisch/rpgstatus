extends KinematicBody2D

var velocity = Vector2()

var sprite = load("res://chararacters/Lifestealer_minimap_icon.png")

var my_stats = {}

func _ready():
	sprite = load(my_stats.icon)
	$Sprite.texture = sprite
	pass # Replace with function body.
	
func _physics_process(delta):
	move_input()
	velocity = move_and_slide(velocity)
	
func move_input():
	velocity = Vector2()
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	velocity = velocity.normalized() * my_stats.move_speed
		
func set_stats(stats):
	my_stats = stats
	print_stats()

func set_specific_stat(attribute, value):
	my_stats[attribute] = value
	
func get_specific_stat(attribute):
	return my_stats[attribute]

func timer_stat_increase(attribute, value):
	var old_attribute
	old_attribute = my_stats[attribute]
	my_stats[attribute] += my_stats[attribute] * (value/100)
	yield(get_tree().create_timer(10), "timeout")
	my_stats[attribute] -= old_attribute * (value/100)

func increase_stat(attribute, value):
	my_stats[attribute] += value
	
func _input(event):
	if event.is_action_pressed("ui_accept"):
		#timer_stat_increase("move_speed", 100)
		print_stats()
	
	if event.is_action_pressed("ui_cancel"):
		#timer_stat_increase("move_speed", 10)
		#print("\ntimer buff")
		print_stats()
		
	#if event.is_action_pressed(""):
	#	get_stats()
		
func print_stats():
	print("\n", my_stats.name , ", the " 
			, my_stats.title, "\n"
			, "Health: " ,  my_stats.health , "\n"
			, "Damage: ", my_stats.damage, "\n"
			, "Movement Speed: ", my_stats.move_speed, "\n"
			, "Attack Speed: " ,my_stats.attack_speed, "\n"
			, "Rotation Speed: ", my_stats.rotation_speed, "\n"
			, "Agility: " , my_stats.agility, "\n"
			, "Strength: ", my_stats.strength, "\n"
			, "Intelligence: ", my_stats.intelligence, "\n"
			, "Agility Gain: ", my_stats.agility_gain, "\n"
			, "Strength Gain: ", my_stats.strength_gain, "\n"
			, "Intelligence Gain: ", my_stats.intelligence_gain)
