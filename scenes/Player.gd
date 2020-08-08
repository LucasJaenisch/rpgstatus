extends "res://scenes/Character.gd"

func _ready():
	pass
	
func _process(delta):
	update()
	
func _physics_process(delta):
  move_input()
  move_and_slide(velocity)
  
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
	#print (velocity)

var width = 1
var red = Color(1,0,0)
var green = Color(0,1,0)
var blue = Color(0,0,1)

func _draw():
	#draw_circle_arc_poly(velocity, 100, 100, 200, Color(1,0,0))
	#draw_line(position, target - position,red, width)
	pass
	#draw_line(velocity, (velocity - velocity).normalized() * my_stats.move_speed,green, width)
