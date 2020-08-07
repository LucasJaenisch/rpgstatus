extends Node

const MAX_SPEED = 550
const MAX_FORCE = 0.5 #force has to be lower or equal to the velocity
var steering_force = Vector2() #direction based on the force
var distance_to_target = Vector2()
var desired_vel = Vector2()

#goes to direction, just that
func steering(cur_pos, target_pos, cur_vel, delta):
	distance_to_target = target_pos - cur_pos #direction of the object and the target
	desired_vel = distance_to_target.normalized() * MAX_SPEED #calculates the velocity to the target
	
	steering_force = (desired_vel - cur_vel) / delta #calculates the force to be apllied
	steering_force = steering_force.clamped(MAX_FORCE) #limits the max value returned by the force
	
	return steering_force

#goes to direction and loses velocity when arrives the near the target  until it stops in the min distance
func steering_and_arriving(cur_pos, target_pos, cur_vel, min_dist, delta):
	
	desired_vel  = distance_to_target.normalized() * MAX_SPEED #calculates the velocity to the target
	
	if distance_to_target.length() > min_dist: #stay in position untill min distance
		steering_force *= (desired_vel - cur_vel) / delta #calculates the force to be apllied
		steering_force = steering_force.clamped(MAX_FORCE) #limits the max value returned by the force
	else:
		steering_force = (desired_vel - cur_vel) / delta #calculates the force to be apllied
		steering_force = steering_force.clamped(MAX_FORCE) #limits the max value returned by the force
	return steering_force
	
func fleeing(cur_pos, target_pos, cur_vel, min_dist, delta):
	distance_to_target = target_pos - cur_pos #direction of the object and the target
	
	if distance_to_target.length() > min_dist: #stay in position untill min distance
		return Vector2(0, 0)
	else:
		desired_vel = - distance_to_target.normalized() * MAX_SPEED # desirable flee velocity
		steering_force = (desired_vel - cur_vel) / delta
		steering_force = steering_force.clamped(MAX_FORCE)
		
	return steering_force
	
func wander(cur_vel, cdist, cradius):
	var circle_center = cur_vel.normalized() * cdist 
	
	#dont rotate the character, but the virtual circle that he creates to move to another direction
	#in the end calculates a direction for the movement (random)
	
	var wander_vector = Vector2(cradius, 0).rotated(randf() * 2 * PI)
	
	steering_force = circle_center + wander_vector #center + direction = moves inside the area of the circle
	steering_force = steering_force.clamped(MAX_FORCE)
	
	return steering_force 
	
func pursuit(cur_pos, target_pos, cur_vel, target_vel, delta):
	return steering(cur_pos + target_vel * delta, target_pos, cur_vel, delta)
