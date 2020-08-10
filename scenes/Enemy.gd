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
	velocity = move_and_slide(velocity)
	target = get_node("../Player").position

func test_seek():
	velocity = steering_control.seek(position, target, velocity, my_stats.move_speed)

func test_flee():
	velocity = steering_control.flee(position, target, velocity, 200, my_stats.move_speed)
	
func test_arrival():
	velocity = steering_control.arrival(position, target, velocity, 200, my_stats.move_speed)

func test_wander():
	velocity = steering_control.wander(position, velocity, 200, my_stats.move_speed)

func draw_circle_arc_poly(center, radius, angle_from, angle_to, color):
	var nb_points = 32
	var points_arc = PoolVector2Array()
	points_arc.push_back(center)
	var colors = PoolColorArray([color])

	for i in range(nb_points + 1):
		var angle_point = deg2rad(angle_from + i * (angle_to - angle_from) / nb_points - 90)
		points_arc.push_back(center + Vector2(cos(angle_point), sin(angle_point)) * radius)
	draw_polygon(points_arc, colors)
