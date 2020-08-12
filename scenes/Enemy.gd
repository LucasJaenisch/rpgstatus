extends "res://scenes/Character.gd"

var steering_control = preload("res://scenes/Steering.tscn").instance()

var target = Vector2(0, 0)

func _ready():
	add_child(steering_control)
	
func _physics_process(delta):
	
	#test_seek()
	test_wander()
	#test_flee()
	#test_arrival()
	
	test_skill()
	
	velocity = move_and_slide(velocity)
	target = get_node("../Player").position
	
func test_skill():
	pass

func test_seek():
	velocity = steering_control.seek(position, target, velocity, my_stats.move_speed)

func test_flee():
	velocity = steering_control.flee(position, target, velocity, 200, my_stats.move_speed)
	
func test_arrival():
	velocity = steering_control.arrival(position, target, velocity, 200, my_stats.move_speed)

func test_wander():
	velocity = steering_control.wander(position, velocity, 200, my_stats.move_speed)
