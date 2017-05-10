extends Node2D

const MAP_WIDTH = 40
const MAP_HEIGHT = 40
const TILE_SIZE = 32

const scn_wall = preload("res://block.tscn")

func _ready():
	gen_cave()
	pass

func gen_cave():
	var NUM_ROOMS = 10
	var room_poses = []
	var room_sizes = []
	for i in range(NUM_ROOMS):
		room_poses.append(Vector2(0,0))
		room_sizes.append(1)
	for y in range(-MAP_HEIGHT/2,MAP_HEIGHT/2):
		for x in range(-MAP_WIDTH/2,MAP_WIDTH/2):
			#randomize()
			var xy = Vector2(x,y)
			if xy.length()>9:
				create_wall_at(xy)
				pass

# spawn tiles
func create_wall_at(loc):
	var wall = scn_wall.instance()
	get_node("blocks").add_child(wall)
	wall.set_pos(loc*TILE_SIZE)