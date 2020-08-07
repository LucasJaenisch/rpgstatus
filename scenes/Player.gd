extends "res://scenes/Character.gd"

func _ready():
	pass
	
func _physics_process(delta):
  move_input()
  velocity = move_and_slide(velocity)
  
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
	velocity = velocity.normalized() * my_stats.move_speed * 1.5
