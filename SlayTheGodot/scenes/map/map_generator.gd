class_name MapGenerator
extends Node

const X_DIST :=30
const Y_DIST :=25
const PLACEMENT_RANDOMESS :=5
const FLOOR := 15
const MAP_WIDTH := 7
const PATHS := 6
const MONSTER_ROOM_WEIGHT := 10.0
const SHOP_ROOM_WEIGHT := 2.5
const CAMPFIRE_ROOM_WEIGHT := 4.0

var random_room_type_weights := 0
var map_data: Array[Array]

func _ready() -> void:
	generate_map()

func generate_map() -> Array[Array]:
	map_data = _generate_initial_grid()
	var starting_points := _get_random_starting_points()
	
	for j in starting_points:
		var current_j := j
		for i in FLOOR -1:
			current_j = _setup_connection(i,current_j)
			
	    	
	var i := 0
	for floor in map_data:
		print("Floor %s" % i)
		var used_rooms = floor.filter(
			func(room: Room): return room.next_rooms.size() > 0
		)
		print(used_rooms)
		i += 1
	return []
	
	
func _generate_initial_grid()-> Array[Array]:
	var result: Array[Array] = []
	
	for i in FLOOR:
		var adjacent_rooms : Array[Room] = []
		
		for j in MAP_WIDTH:
			var current_room := Room.new()
			var offset := Vector2(randf(),randf()) * PLACEMENT_RANDOMESS
			current_room.position= Vector2(j * X_DIST, i * -Y_DIST) + offset
			current_room.row = i
			current_room.column = j
			current_room.next_rooms = []
		
			#Boss room has a non-random Y
			if i == FLOOR - 1:
				current_room.position.y = (i + 1)* -Y_DIST
		
			adjacent_rooms.append(current_room)
			
		result.append(adjacent_rooms)
	
	return result
func _get_random_starting_points() -> Array[int]:
	var y_coordinates : Array[int]
	var unique_points : int =0
	
	while unique_points < 2:
		unique_points = 0
		y_coordinates = []
		for i in PATHS:
			var starting_point := randi_range(0,MAP_WIDTH -1)
			if  not y_coordinates.has(starting_point):
				unique_points += 1

			y_coordinates.append(starting_point)


	return y_coordinates
func _setup_connection(i: int , j:int) -> int:
	var next_room: Room
	var current_room:= map_data[i][j] as Room
	
	while not next_room or _world_cross_existing_path(i,j,next_room):
		var random_j :=clampi(randi_range(j-1,j+1),0,MAP_WIDTH -1)
		next_room = map_data[i + 1][random_j]
		
	current_room.next_rooms.append(next_room)
	return next_room.column
	
func _world_cross_existing_path(i:int, j:int, room: Room) -> bool:
	var left_neighbor: Room
	var right_neighbor: Room
	
	# if j == 0, no left neighbor
	if j > 0:
		left_neighbor = map_data[i][j - 1]
	# if j == MAP_WIDTH -1, no right neighbor
	if j < MAP_WIDTH - 1:
		right_neighbor = map_data[i][j + 1]
	#car't cross in right dir if right neighbor goes to left
	if right_neighbor and room.column > j:
		for next_room:Room in right_neighbor.next_rooms:
			if next_room.column < room.column:
				return true
	#car't cross in left dir if left neighbor goes to right
	if left_neighbor and room.column < j:
		for next_room:Room in left_neighbor.next_rooms:
			if next_room.column > room.column: 
				return true
		
	return false