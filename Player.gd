extends KinematicBody2D

const MAX_SPEED = 16*6 #pixels per second
const MAX_HEALTH = 5
const ACCELERATION = 2

var mouse_mode = false

var curHealth
var vel
var facing = "down"
#var bullet = preload("bullet.tscn")

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	# movement input
	var invec = Vector2(0,0)
	if Input.is_action_pressed("move_up"):
		invec.y -= 1
	if Input.is_action_pressed("move_down"):
		invec.y += 1
	if Input.is_action_pressed("move_left"):
		invec.x -= 1
	if Input.is_action_pressed("move_right"):
		invec.x += 1
	# sprite facing direction
	var moving = false
	if invec.x>0:
		facing = "right"
		moving = true
	elif invec.x<0:
		facing = "right"
		moving = true
	elif invec.y>0:
		facing = "down"
		moving = true
	elif invec.y<0:
		facing = "up"
		moving = true
	if moving:
		var anim_state="run_"+facing
	else:
		var anim_state="idle_"+facing
	# move
	vel = invec.normalized() * MAX_SPEED * delta
	var rem = move(vel)
	# slide fix
	if (is_colliding()):
		var n = get_collision_normal()
		var motion = n.slide(rem)
		move(motion)
	
	# attack
	if Input.is_action_pressed("fire"):
#		bullet.instance()
		pass


