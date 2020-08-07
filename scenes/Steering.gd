extends Node

const MAX_SPEED = 300
const MAX_FORCE = 0.5
var steering_force = Vector2()


func steering(cur_pos, target_pos, cur_vel, delta):
	var distance_to_target = target_pos - cur_pos
	var desired_vel = distance_to_target.normalized()
	
	steering_force = (desired_vel - cur_vel) / delta
	steering_force = steering_force.clamped(MAX_FORCE)
	
	return steering_force
