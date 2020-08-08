extends Node2D

const MAX_SPEED = 550
const MAX_FORCE = 50 #force has to be lower or equal to the velocity 
#var steering_force = Vector2() #direction based on the force

var distance_to_target = Vector2()
var desired_velocity = Vector2()
var direction = Vector2()
var steering_force = Vector2()

var circle_center = Vector2()
var displacement = Vector2()

var width = 1
var red = Color(1,0,0)
var green = Color(0,1,0)
var blue = Color(0,0,1)

var pos = Vector2()
var vel = Vector2()

var rand = RandomNumberGenerator.new()

func _ready():
	rand.randomize()

func _process(delta):
	update()

func _draw():
	#draw_circle_arc_poly(velocity, 100, 100, 200, Color(1,0,0))
	
	draw_line(Vector2.ZERO, vel, red, width)
	
	draw_line(Vector2.ZERO, desired_velocity, green, width) #drawline adds the vector with the current position of the node using it fox the first vector
	
	draw_line(vel, steering_force + desired_velocity, blue, width)

#goes to direction, just that
func seek(position, target, velocity, move_speed):
	
	desired_velocity = (target - position).normalized() * move_speed 
	steering_force = (desired_velocity - velocity) / MAX_FORCE
	
	velocity += steering_force
	vel = velocity
	
	return velocity

func arrival(position, target, velocity, slow_radius,  move_speed):
	distance_to_target = position.distance_to(target)
	desired_velocity = (target - position).normalized() * move_speed 
	if distance_to_target < slow_radius:
		desired_velocity *= (distance_to_target / move_speed) * 0.8 + 0.2 #offset [0, 0.8] -> [0,1]
	steering_force = (desired_velocity - velocity) / MAX_FORCE
	velocity += steering_force
	vel = velocity
	return velocity

func flee(position, target, velocity, run_away_distance, move_speed):
	distance_to_target = position.distance_to(target)
	if distance_to_target > run_away_distance:
		desired_velocity *= (distance_to_target / move_speed)
		steering_force = (desired_velocity - velocity) / MAX_FORCE
		velocity += steering_force
		return desired_velocity
	else:
		desired_velocity = - (target - position).normalized() * move_speed
		steering_force = (desired_velocity - velocity) / MAX_FORCE
	
	velocity += steering_force
	vel = velocity
	
	return velocity

func wander(position, velocity, circle_radius, distance):
	direction = velocity
	circle_center = velocity - position
	circle_center.normalized()
	circle_center = circle_center * distance
	rand.randomize()
	displacement = Vector2(circle_radius, 0).rotated(randf() * 2 * PI)
	
	var wander_force = displacement - position
	
	steering_force = wander_force.clamped(1)
	
	return steering_force
