extends KinematicBody2D

export (int) var speed = 200

var velocity = Vector2()

export var health = 1.0 setget set_health, get_health
export var damage = 1.0
export var movespeed = 10.0
export var agility = 10.0
export var strength = 10.0
export var inteligence = 10.0
export var buff_value = 10.0


# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.


func get_input():
	look_at(get_global_mouse_position())
	velocity = Vector2()
	if Input.is_action_pressed("ui_down"):
		velocity = Vector2(0, speed)
	elif Input.is_action_pressed("ui_up"):
		velocity = Vector2(0, -speed)
	elif Input.is_action_pressed("ui_left"):
		velocity = Vector2(-speed, 0)
	elif Input.is_action_pressed("ui_right"):
		velocity = Vector2(speed, 0)
		
func set_health(value):
	health = value
	
func get_health():
	return health
	
func _physics_process(delta):
	get_input()
	velocity = move_and_slide(velocity)

func timer_strength(value):
	var old_strength
	old_strength = strength
	strength += strength * (value/100)
	yield(get_tree().create_timer(10), "timeout")
	strength -= old_strength * (value/100)

func increase_strength(value):
	strength += value
	
#func _input(event):
#	if event.is_action_pressed("ui_right"):
#		increase_strength(buff_value)
#	
#	if event.is_action_pressed("ui_left"):
#		timer_strength(buff_value)
#		print("\ntimer buff")
#		get_stats()
#	if event.is_action_pressed("ui_select"):
		
#		print("\nbuff: ", buff_value)
#		get_stats()
func get_stats():
	print("\nhealth: ", health, 
				"\ndamage: ", damage,
				"\nmovespeed: ", movespeed,
				"\nagility: ", agility,
				"\nstrength: ", strength)
