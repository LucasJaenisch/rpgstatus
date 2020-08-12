extends KinematicBody2D

var velocity = Vector2()

var sprite

var my_stats = {}

signal attacked(damage)

func buff_percentage_timer(attribute, value, timer):
	var old_attribute
	old_attribute = my_stats[attribute]
	my_stats[attribute] += my_stats[attribute] * (value/100)
	yield(get_tree().create_timer(timer), "timeout")
	my_stats[attribute] -= old_attribute * (value/100)
	
func buff_static_timer(attribute, value, timer):
	my_stats[attribute] += value
	yield(get_tree().create_timer(timer), "timeout")
	my_stats[attribute] -= value
	
func buff_percentage_permanent(attribute, value):
	my_stats[attribute] += my_stats[attribute] * (value/100)
	
func buff_static_permanent(attribute, value):
	my_stats[attribute] += value

func attack(damage):
	emit_signal("attacked", damage)
	
func take_damage(damage):
	#animation hurt
	my_stats.health -= damage

func print_stats():
	print("\n", my_stats.my_name , ", the " 
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

func on_coin_grabbed(coin_value):
	print(coin_value)
	my_stats.gold += coin_value
	print("gold ", my_stats.gold)
