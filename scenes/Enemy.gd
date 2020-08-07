extends "res://scenes/Character.gd"

var steering_control = preload("res://scenes/Steering.gd").new();

var steering_force = Vector2()

onready var target 

	
func _physics_process(delta):
	var velocity_temp = Vector2()
	velocity = Vector2()
	
	#test_steering(delta)
	#test_steering_and_arriving(delta)
	#test_fleeing(delta)
	#test_wander()
	test_pursuit(delta)
	move_and_collide(velocity + velocity_temp)
	target = get_viewport().get_mouse_position()

func test_steering(delta):
	velocity = steering_control.steering(position, get_viewport().get_mouse_position(), velocity, delta)

func test_steering_and_arriving(delta):
	velocity = steering_control.steering_and_arriving(position, get_viewport().get_mouse_position(), velocity, 100, delta)

func test_fleeing(delta):
	velocity = steering_control.fleeing(position, get_viewport().get_mouse_position(), velocity, 100, delta)

func test_wander():
	velocity = steering_control.wander(velocity, 300, 100)

func test_pursuit(delta):
	velocity = steering_control.pursuit(position, get_viewport().get_mouse_position(), velocity, get_viewport().get_mouse_position() * 200, delta)
