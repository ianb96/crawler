extends KinematicBody2D

const MAX_SPEED = 16*6 #pixels per second
const MAX_HEALTH = 5
const ACCELERATION = 0.2

var mouse_mode = false

var cur_health
var vel = Vector2(0,0)
var facing = "down"
var anim_state = ""
var scn_bullet = preload("res://bullet.tscn")
onready var gunpos = get_node("sprite/gunpos").get_pos()

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
	if invec.x>0.1:
		facing = "right"
		moving = true
	elif invec.x<-0.1:
		facing = "left"
		moving = true
	elif invec.y>0.1:
		facing = "down"
		moving = true
	elif invec.y<-0.1:
		facing = "up"
		moving = true
	else:
		invec = Vector2(0,0)
	var new_anim_state
	if moving:
		new_anim_state="run_"+facing
	else:
		new_anim_state="idle_"+facing
	if new_anim_state != anim_state:
		#best way?
		get_node("anim").play(new_anim_state)
		anim_state = new_anim_state
	# move
	vel.x = lerp(vel.x, invec.normalized().x * MAX_SPEED * delta, ACCELERATION)
	vel.y = lerp(vel.y, invec.normalized().y * MAX_SPEED * delta, ACCELERATION)
	var rem = move(vel)
	# slide fix
	if (is_colliding()):
		var n = get_collision_normal()
		var motion = n.slide(rem)
		vel = n.slide(vel)
		move(motion)
	# attack
	if Input.is_action_pressed("fire"):
		var b = scn_bullet.instance()
		b.set_pos(gunpos)

func takeDamage(var amount):
	cur_health-=amount
	if cur_health<=0:
		print("dead")
