extends Node2D

const MAX_SPEED = 550
const MAX_FORCE = 50 #force has to be lower or equal to the velocity 

#forces
var distance_to_target = Vector2()
var desired_velocity = Vector2()
var steering_force = Vector2()

#wander
var circle_center = Vector2()
var circle_radius = Vector2()

#colors
var width = 3
var red = Color(1,0,0,1)
var green = Color(0,1,0,1)
var blue = Color(0,0,1,1)
var other = Color(1, 1, 1, 0.5)
var black = Color(0, 0, 0, 0.5)
var colorir = true

#redudant variables
var vel = Vector2()
var random_point = Vector2()

var rand = RandomNumberGenerator.new()

func _ready():
	rand.randomize()

func _process(delta):
	update()

func _physics_process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		colorir = !colorir
		if colorir:
			red = Color(1,0,0,0)
			green = Color(0,1,0,0)
			blue = Color(0,0,1,0)
			other = Color(1, 1, 1, 0)
			black = Color(0, 0, 0, 0)
			print("coloriu")
		else:
			red = Color(1,0,0,1)
			green = Color(0,1,0,1)
			blue = Color(0,0,1,1)
			other = Color(1, 1, 1, 0.5)
			black = Color(0, 0, 0, 1)
			


func _draw():
  #draw_circle_arc_poly(velocity, 100, 100, 200, Color(1,0,0))
  
	#wander circle
	draw_circle(circle_center, circle_radius, other)
	draw_circle(random_point, 4, black)
	#velocity
	draw_line(position, vel, red, width)
	#desired
	draw_line(circle_center, desired_velocity, green, width) #drawline adds the vector with the current position of the node using it fox the first vector
	#steering
	draw_line(position, random_point - position , blue, width)
	
	#velocity
	#draw_line(position, vel, red, width)
	#desired
	#draw_line(position, desired_velocity, green, width) #drawline adds the vector with the current position of the node using it fox the first vector
	#steering
	#draw_line(vel, steering_force + desired_velocity, blue, width)


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
		desired_velocity *= (distance_to_target / move_speed) * 0.8 + 0.2 #offset [0, 0.8] -> [0,1]steering_force = (desired_velocity - velocity) / MAX_FORCE
	velocity += steering_force
	vel = velocity
	return velocity

func flee(position, target, velocity, run_away_distance, move_speed):
	distance_to_target = position.distance_to(target)
	if distance_to_target > run_away_distance:
		desired_velocity = Vector2.ZERO
		return desired_velocity
	else:
		desired_velocity = - (target - position).normalized() * move_speed
		steering_force = (desired_velocity - velocity) / MAX_FORCE
  
	velocity += steering_force
	vel = velocity
  
	return velocity

func wander(position, velocity, radius, move_speed):
	
	circle_radius = radius
	circle_center = velocity.normalized() * circle_radius

	rand.randomize()

	random_point = (Vector2(circle_radius, 0).rotated(rand.randf() * 2 * PI)) + circle_center
	desired_velocity = (random_point - circle_center).normalized() * circle_radius + circle_center

	steering_force = (desired_velocity + velocity) / MAX_FORCE
	
	velocity += steering_force

	velocity = velocity.normalized() * move_speed / 4
	
	vel = velocity
	
	return velocity
