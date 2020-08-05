extends "res://scenes/Character.gd"

func _ready():
  pass # Replace with function body.

func _physics_process(delta):
  move_input()
  velocity = move_and_slide(velocity)
  
func move_input():
	velocity = Vector2()
	if Input.is_action_pressed("ui_down"):
		print(position)
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		print(position)
		velocity.y -= 1
	if Input.is_action_pressed("ui_left"):
		print(position)
		velocity.x -= 1
	if Input.is_action_pressed("ui_right"):
		print(position)
		velocity.x += 1
	velocity = velocity.normalized() * my_stats.move_speed

  
func _input(event):
	if event.is_action_pressed("ui_cancel"):
		print_tree()
		#print(my_stats)
