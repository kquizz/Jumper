extends Node

# enum Colors {BLUE, YELLOW, GREEN, RED}
var colors = ["blue", "yellow", "green", "red"]
@export var level = 1

@onready var green_player: CharacterBody2D = $"../Players/Green Player"
@onready var blue_player: CharacterBody2D = $"../Players/Blue Player"

var players_starting_locations = { 
"green": [[250, 212], [250, 212]],
"blue": [[300, 161], [300, 212]]}

var keys = {}
var gems = {}
var flags = {}

func _ready():
	for color in colors:
		keys[color] = 0
		gems[color] = 0
		flags[color] = 0
	setup_level()

func add_key(color): keys[color] += 1
func add_gem(color): gems[color] += 1
func add_flag(color): flags[color] += 1
	
func has_key(color): return keys[color] > 0

func remove_key(color):
	if keys[color] > 0:
		keys[color] -= 1

func check_level_finished():
	if flags["blue"] >= 1 and flags["green"] >= 1:
		level += 1
		setup_level()

func setup_level():
	green_player.position = Vector2(players_starting_locations["green"][level - 1][0], players_starting_locations["green"][level - 1][1])
	blue_player.position = Vector2(players_starting_locations["blue"][level - 1][0], players_starting_locations["blue"][level - 1][1])
	#reload_players()

func reload_players():
	# Reload green player
	var green_player_scene = load("res://scenes/players/green-player.tscn")
	var new_green_player = green_player_scene.instance()
	new_green_player.position = Vector2(players_starting_locations["green"][level - 1][0], players_starting_locations["green"][level - 1][1])
	green_player.get_parent().add_child(new_green_player)
	green_player.queue_free()
	green_player = new_green_player

	# Reload blue player
	var blue_player_scene = load("res://scenes/players/blue-player.tscn")
	var new_blue_player = blue_player_scene.instance()
	new_blue_player.position = Vector2(players_starting_locations["blue"][level - 1][0], players_starting_locations["blue"][level - 1][1])
	blue_player.get_parent().add_child(new_blue_player)
	blue_player.queue_free()
	blue_player = new_blue_player
