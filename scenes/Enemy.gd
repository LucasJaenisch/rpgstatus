extends "res://scenes/Character.gd"

var steering_control = preload("res://scenes/Steering.gd")

const MAX_SPEED = 300
const MAX_FORCE = 0.02
var steering_force = Vector2()

#var velocity = Vector2()

onready var target 

func _ready():
	#_fixed_process(true)

	pass
	
func _physics_process(delta):
	velocity = Vector2()
	
	velocity = steering(position, get_viewport().get_mouse_position(), velocity, delta)
	velocity = move_and_collide(velocity  * MAX_SPEED)
	target = get_viewport().get_mouse_position()
	

func steering(cur_pos, target_pos, cur_vel, delta):
	var distance_to_target = target_pos - cur_pos
	var desired_vel = distance_to_target.normalized()
	
	steering_force = (desired_vel - cur_vel) / delta
	steering_force = steering_force.clamped(MAX_FORCE)
	
	return steering_force
